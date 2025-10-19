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
    
    // Загружаем записи из дневника
    List<CalendarRecordData> diaryRecords = [];
    if (recordsString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(recordsString);
        diaryRecords = jsonList.map((item) => CalendarRecordData.fromJson(item)).toList();
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
          String fromTimeType = appointment['from_time_type'] ?? '';
          
          if (dateStr.isNotEmpty) {
            DateTime appointmentDate = DateTime.parse(dateStr);
            
            // Создаем время
            String timeStr = fromTime;
            if (fromTimeType == 'PM' && fromTime != '12:00') {
              // Конвертируем PM время
              List<String> timeParts = fromTime.split(':');
              int hour = int.parse(timeParts[0]);
              if (hour != 12) hour += 12;
              timeStr = '${hour.toString().padLeft(2, '0')}:${timeParts[1]}';
            }
            
            // Улучшаем отображение типа приема
            String appointmentType = _getAppointmentTypeDisplay(appointment['description']);
            
            // Создаем запись для календаря
            CalendarRecordData appointmentRecord = CalendarRecordData(
              date: appointmentDate,
              title: '${timeStr} - ${appointment['patient']['first_name'] ?? 'Пациент'} - $appointmentType',
              category: 'Приемы',
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
      return 'Голосовой звонок';
    } else if (description.contains('ContactMethods.videoCall')) {
      return 'Видеозвонок';
    } else if (description.contains('ContactMethods.chat')) {
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
    Color? backgroundColor;
    if (recordsForDay.isNotEmpty) {
      final firstCategory = recordsForDay.first.category;
      if (firstCategory == 'Cat1') {
        backgroundColor = Colors.red;
      } else if (firstCategory == 'Cat2') {
        backgroundColor = Colors.yellow;
      } else if (firstCategory == 'Cat3') {
        backgroundColor = Colors.green;
      } else {
        backgroundColor = Color.fromARGB(255, 255, 255, 255);
      }
    } else {
      backgroundColor = Color.fromARGB(255, 255, 255, 255);
    }

    // Определяем цвета контуров для дополнительных категорий
    List<Color> borderColors = [];
    if (recordsForDay.length >= 2) {
      final secondCategory = recordsForDay[1].category;
      if (secondCategory == 'Cat1') {
        borderColors.add(Colors.red);
      } else if (secondCategory == 'Cat2') {
        borderColors.add(Colors.yellow);
      } else if (secondCategory == 'Cat3') {
        borderColors.add(Colors.green);
      }
    }
    if (recordsForDay.length >= 3) {
      final thirdCategory = recordsForDay[2].category;
      if (thirdCategory == 'Cat1') {
        borderColors.add(Colors.red);
      } else if (thirdCategory == 'Cat2') {
        borderColors.add(Colors.yellow);
      } else if (thirdCategory == 'Cat3') {
        borderColors.add(Colors.green);
      }
    }

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
                color: borderColors.first, 
                width: 2.0,
              )
            : null,
        ),
        alignment: alignment,
        child: Stack(
          children: [
            Text('${day.day}', style: selectedTextStyle),
            // Дополнительные контуры
            if (borderColors.length >= 2)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColors[1],
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            if (borderColors.length >= 3)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColors[2],
                      width: 1.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
