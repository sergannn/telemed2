import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:get_it/get_it.dart';

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

  void _updateRecord(CalendarRecordData updatedRecord) {
    final index = _calendarRecords.indexWhere((r) => r.date.compareWithoutTime(updatedRecord.date));
    if (index != -1) {
      setState(() {
        _calendarRecords[index] = updatedRecord;
      });
      _saveCalendarRecords();
    }
  }

  void _editRecord(BuildContext context, CalendarRecordData record) async {
    final updatedRecord = await Navigator.push<CalendarRecordData>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateRecordPage(
          event: record,
          onRecordAdd: _updateRecord,
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
            printLog('Selected day: $selectedDay');
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

    // Определяем цвета контуров для дополнительных категорий
    
    List<Color> borderColors = [];
    if (recordsForDay.length >= 2) {
      borderColors.add(getCategoryColor(recordsForDay[1].category));
    }
    if (recordsForDay.length >= 3) {
      borderColors.add(getCategoryColor(recordsForDay[2].category));
    }
    print("its boreders");
    print(borderColors);
    return GestureDetector(
      onDoubleTap: () {
        if (recordsForDay.isNotEmpty) {
          _editRecord(context, recordsForDay.first);
        }
      },
      child: AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: borderColors.isNotEmpty 
            ? Border.all(
                color: borderColors.length >= 2 ? borderColors[1] : backgroundColor,
                width: 3.0,
              )
            : null,
        ),
        alignment: alignment,
        child: Stack(
          children: [
            Text('${day.day}', style: selectedTextStyle),
            // Дополнительные контуры
          
          ],
        ),
      ),
    );
  }
}
