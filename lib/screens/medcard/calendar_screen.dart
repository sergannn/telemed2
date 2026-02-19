import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart' hide getIt;
import 'package:doctorq/utils/utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<CalendarRecordData> _calendarRecords = [];

  @override
  void initState() {
    super.initState();
    _loadCalendarRecords();
  }

  Future<void> _loadCalendarRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsString = prefs.getString('calendar_records');
    
    // Печатаем сырые данные из SharedPreferences (для отладки)
    print('=== SHARED PREFS calendar_records ===');
    print('raw length: ${recordsString?.length ?? 0}');
    if (recordsString != null && recordsString.isNotEmpty) {
      print('raw (first 500 chars): ${recordsString.length > 500 ? recordsString.substring(0, 500) + "..." : recordsString}');
    } else {
      print('raw: null или пусто');
    }
    
    // Загружаем записи из дневника
    List<CalendarRecordData> diaryRecords = [];
    if (recordsString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(recordsString);
        diaryRecords = jsonList.map((item) => CalendarRecordData.fromJson(item)).toList();
        print('Дневник: загружено ${diaryRecords.length} записей из prefs');
        for (var r in diaryRecords) {
          print('  ${r.date.toString().substring(0, 10)} | ${r.category} | ${r.title}');
        }
      } catch (e) {
        print('Error decoding calendar records: $e');
      }
    }
    
    // Инициализируем записи дневника
    _calendarRecords = diaryRecords;
    
    // Загружаем предстоящие сеансы
    await _loadAppointmentsToCalendar();
    
    setState(() {
      printLog('_calendarRecords after load: ${_calendarRecords.map((e) => e.toJson()).toList()}');
    });
    
    // Итог по датам (события на каждую дату)
    final byDate = <String, List<CalendarRecordData>>{};
    for (var r in _calendarRecords) {
      final key = r.date.toString().substring(0, 10);
      byDate.putIfAbsent(key, () => []).add(r);
    }
    print('=== СОБЫТИЯ ПО ДАТАМ (дневник) ===');
    final sortedDates = byDate.keys.toList()..sort();
    for (var d in sortedDates) {
      print('$d: ${byDate[d]!.length} заметок — ${byDate[d]!.map((e) => e.title).join("; ")}');
    }
    // Вторник 3 февраля (текущий и следующий год)
    final feb3Keys = ['2025-02-03', '2026-02-03'];
    for (var key in feb3Keys) {
      if (byDate.containsKey(key)) {
        final list = byDate[key]!;
        print('>>> ВТОРНИК 3 ФЕВРАЛЯ ($key): ${list.length} заметок');
        for (var i = 0; i < list.length; i++) {
          print('    ${i + 1}. [${list[i].category}] ${list[i].title}');
        }
      } else {
        print('>>> ВТОРНИК 3 ФЕВРАЛЯ ($key): 0 заметок');
      }
    }
    print('===================================');
  }
  
  Future<void> _loadAppointmentsToCalendar() async {
    try {
      // Получаем предстоящие сеансы из store
      AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();
      List<Map<String, dynamic>> appointments = storeAppointmentsStore.appointmentsDataList.cast<Map<String, dynamic>>();
      
      print("DEBUG: Loading ${appointments.length} appointments to calendar in MedCard (Doctor)");
      
      for (var appointment in appointments) {
        try {
          // Парсим дату сеанса
          String dateStr = appointment['date'] ?? '';
          String fromTime = appointment['from_time'] ?? '';
          
          if (dateStr.isNotEmpty) {
            DateTime appointmentDate = DateTime.parse(dateStr);
            
            // Показываем время как пришло с бэкенда (уже 24h)
            String timeStr = fromTime;
            
            // Улучшаем отображение типа приема
            String appointmentType = _getAppointmentTypeDisplay(appointment['description']);
            
            // Создаем запись для календаря
            CalendarRecordData appointmentRecord = CalendarRecordData(
              date: appointmentDate,
              title: '${timeStr} - ${appointment['patient']['first_name'] ?? 'Пациент'} - $appointmentType',
              category: 'Предстоящие сеансы',
              description: 'ID: ${appointment['id']?.toString() ?? 'N/A'}',
            );
            
            _calendarRecords.add(appointmentRecord);
            print("DEBUG: Added appointment to MedCard calendar (Doctor): ${appointmentRecord.title} on ${appointmentDate.toString()}");
          }
        } catch (e) {
          print("DEBUG: Error processing appointment in MedCard (Doctor): $e");
        }
      }
    } catch (e) {
      print("DEBUG: Error loading appointments to MedCard calendar (Doctor): $e");
    }
  }
  
  String _getAppointmentTypeDisplay(String? description) {
    if (description == null) return 'Прием';
    
    if (description.contains('ContactMethods.voiceCall')) {
      return 'Аудио';
    } else if (description.contains('ContactMethods.videoCall')) {
      return 'Видео';
    } else if (description.contains('ContactMethods.chat') || description.contains('ContactMethods.message')) {
      return 'Чат';
    } else {
      return 'Прием';
    }
  }

  Future<void> _saveCalendarRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsString = jsonEncode(_calendarRecords.map((record) => record.toJson()).toList());
    await prefs.setString('calendar_records', recordsString);
  }

  void _addRecord(CalendarRecordData newEvent) {
    print('newEvent.date: ${newEvent.date}, _calendarRecords: ${_calendarRecords.map((e) => e.date)}');
    setState(() {
      _calendarRecords.add(newEvent);
    });
    _saveCalendarRecords();
  }

  bool _sameRecord(CalendarRecordData r, CalendarRecordData old) {
    return r.date.year == old.date.year &&
        r.date.month == old.date.month &&
        r.date.day == old.date.day &&
        r.date.hour == old.date.hour &&
        r.date.minute == old.date.minute &&
        r.title == old.title &&
        (r.category ?? '') == (old.category ?? '');
  }

  void _updateRecord(CalendarRecordData updatedRecord, {CalendarRecordData? oldRecord}) {
    setState(() {
      if (oldRecord != null) {
        _calendarRecords.removeWhere((r) => _sameRecord(r, oldRecord));
      }
      _calendarRecords.add(updatedRecord);
    });
    _saveCalendarRecords();
  }

  void _deleteRecord(CalendarRecordData record) {
    setState(() {
      _calendarRecords.removeWhere((r) => _sameRecord(r, record));
    });
    _saveCalendarRecords();
  }

  void _editRecord(BuildContext context, CalendarRecordData record) async {
    await Navigator.push<CalendarRecordData>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateRecordPage(
          event: record,
          onRecordAdd: (updated) => _updateRecord(updated, oldRecord: record),
          onRecordDelete: () => _deleteRecord(record),
        ),
      ),
    );
  }

  bool _isAppointmentRecord(CalendarRecordData record) {
    return (record.category == 'Приемы' || record.category == 'Предстоящие сеансы') &&
        (record.description != null && record.description!.contains('ID:'));
  }

  void _openRecord(BuildContext context, CalendarRecordData record) {
    if (_isAppointmentRecord(record)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppointmentsScreen()),
      );
    } else {
      _editRecord(context, record);
    }
  }

  void _onDaySelected(DateTime selectedDay) {
    final recordsForDay = _calendarRecords
        .where((r) => r.date.compareWithoutTime(selectedDay))
        .toList();

    if (recordsForDay.isEmpty) return;

    if (recordsForDay.length == 1) {
      _openRecord(context, recordsForDay.first);
      return;
    }

    // Несколько событий — показываем выбор во всплывающем окне
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Text(
                'Записи на ${DateFormat('d MMMM', 'ru').format(selectedDay)}',
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Divider(height: 1),
            ...recordsForDay.map((record) {
              final isTimeSet = record.date.hour != 0 || record.date.minute != 0;
              final timeStr = isTimeSet
                  ? DateFormat('HH:mm').format(record.date)
                  : 'Без времени';
              final canDelete = !_isAppointmentRecord(record);
              return ListTile(
                leading: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: getCategoryColor(record.category),
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text(record.title),
                subtitle: Text(
                  '${getCategoryName(record.category)} · $timeStr',
                  style: Theme.of(ctx).textTheme.bodySmall,
                ),
                trailing: canDelete
                    ? IconButton(
                        icon: const Icon(Icons.close, size: 22),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: ctx,
                            builder: (dialogCtx) => AlertDialog(
                              title: const Text('Удалить запись?'),
                              content: Text('Удалить «${record.title}»?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogCtx, false),
                                  child: const Text('Отмена'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(dialogCtx, true),
                                  child: const Text('Удалить'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true && ctx.mounted) {
                            Navigator.pop(ctx);
                            _deleteRecord(record);
                          }
                        },
                      )
                    : null,
                onTap: () {
                  Navigator.pop(ctx);
                  _openRecord(context, record);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TableCalendar(
          availableCalendarFormats: const { CalendarFormat.month: 'Month',},
          weekNumbersVisible: false,
          onCalendarCreated: (pageController) {},
          calendarBuilders: CalendarBuilders(
            defaultBuilder: dayBuilder,
            todayBuilder: dayBuilder,
          ),
          locale: 'ru_RU',
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          onDaySelected: (selectedDay, focusedDay) {
            _onDaySelected(selectedDay);
          },
        ),
        FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 96, 159, 222),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Устанавливаем радиус скругления
          ),
          child: const Icon(Icons.add,
          color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateRecordPage(
                  onRecordAdd: _addRecord,
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  Widget? dayBuilder(context, day, focusedDay) {
    final selectedTextStyle = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16.0,
    );
    final margin = const EdgeInsets.all(6.0);
    final padding = EdgeInsets.zero;
    final alignment = Alignment.center;
    const duration = Duration(milliseconds: 250);

    // Находим все записи для этой даты
    final recordsForDay = _calendarRecords.where(
      (record) => record.date.compareWithoutTime(day),
    ).toList();

    // Определяем основной цвет фона (первая категория)
    // Цвета: голубоватый (Приемы), желтоватый (Лекарства), нежно-розовый (Упражнения)
    Color? backgroundColor;
    if (recordsForDay.isNotEmpty) {
      
      backgroundColor = getCategoryColor(recordsForDay.first.category);
    } else {
      backgroundColor = Color.fromARGB(255, 255, 255, 255);
    }

    // Цвета обводок: вторая и третья категория (первая — фон)
    List<Color> ringColors = [];
    if (recordsForDay.length >= 2) {
      ringColors.add(getCategoryColor(recordsForDay[1].category));
    }
    if (recordsForDay.length >= 3) {
      ringColors.add(getCategoryColor(recordsForDay[2].category));
    }

    // Внешний круг: фон + первая обводка (вторая категория)
    Widget cell = AnimatedContainer(
      duration: duration,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: ringColors.isNotEmpty
            ? Border.all(
                color: ringColors.first,
                width: 3.0,
              )
            : null,
      ),
      alignment: alignment,
      child: ringColors.length == 2
          ? Container(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ringColors[1],
                  width: 2.5,
                ),
              ),
              child: Center(
                child: Text('${day.day}', style: selectedTextStyle),
              ),
            )
          : Center(child: Text('${day.day}', style: selectedTextStyle)),
    );
    return GestureDetector(child: cell);
  }
}
