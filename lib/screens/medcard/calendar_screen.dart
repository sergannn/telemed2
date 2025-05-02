import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';

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
    if (recordsString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(recordsString);
        _calendarRecords = jsonList.map((item) => CalendarRecordData.fromJson(item)).toList();
      } catch (e) {
        print('Error decoding calendar records: $e');
        _calendarRecords = [];
      }
    }
    setState(() {
      printLog('_calendarRecords after load: ${_calendarRecords.map((e) => e.toJson()).toList()}');
    });
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
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
      ),
      body: TableCalendar(
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

    Color? backgroundColor;
    final record = _calendarRecords.firstWhere(
      (record) => record.date.compareWithoutTime(day),
      orElse: () => CalendarRecordData(title: '', date: day, category: null),
    );

    if (record.category == 'Cat1') {
      backgroundColor = Colors.red;
    } else if (record.category == 'Cat2') {
      backgroundColor = Colors.yellow;
    } else if (record.category == 'Cat3') {
      backgroundColor = Colors.green;
    } else {
      backgroundColor = Color.fromARGB(255, 255, 255, 255);
    }

    return GestureDetector(
      onDoubleTap: () {
        if (record.title.isNotEmpty) {
          _editRecord(context, record);
        }
      },
      child: AnimatedContainer(
        duration: duration,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: alignment,
        child: Text('${day.day}', style: selectedTextStyle),
      ),
    );
  }
}
