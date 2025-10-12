import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'base_tool.dart';

class ShowCalendarTool extends BaseTool {
  @override
  String get name => 'ShowCalendarTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final String action = parameters['action'] as String;
    final String dateStr = parameters['Date'] as String;

    // Создаем toolSummary
    final String toolSummary = '<tool_summary>I have provided a calendar view for the user to $action on the date: $dateStr</tool_summary>';

    // Возвращаем Map с toolWidget и toolSummary
    return {
      'toolWidget': ShowCalendarToolWidget(action: action, dateStr: dateStr),
      'toolSummary': toolSummary,
    };
  }
}

class ShowCalendarToolWidget extends StatefulWidget {
  final String action;
  final String dateStr;

  const ShowCalendarToolWidget({
    Key? key,
    required this.action,
    required this.dateStr,
  }) : super(key: key);

  @override
  _ShowCalendarToolWidgetState createState() => _ShowCalendarToolWidgetState();
}

class _ShowCalendarToolWidgetState extends State<ShowCalendarToolWidget> {
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedEvents = [];
    _events = {};
    _initializeDate();
    _loadEvents();
  }

  void _initializeDate() {
    DateTime initialDate;
    try {
      List<String> parts = widget.dateStr.split('.');
      initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (e) {
      initialDate = DateTime.now();
    }
    _focusedDay = initialDate;
    _selectedDay = initialDate;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_calendar.json');
  }

  Future<void> _loadEvents() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          final List<dynamic> eventList = jsonDecode(contents);
          _processEvents(eventList);
        } else {
          // Локальный файл пустой, копируем из assets
          _copyEventsFromAssets();
        }
      } else {
        // Локальный файл не найден, копируем из assets
        _copyEventsFromAssets();
      }
    } catch (e) {
      print("Error loading events: $e");
    }
  }

    Future<void> _copyEventsFromAssets() async {
    try {
      final contents = await rootBundle.loadString('assets/local_calendar.json');
      final file = await _localFile;
      await file.writeAsString(contents);
      final List<dynamic> eventList = jsonDecode(contents);
      _processEvents(eventList);
    } catch (e) {
      print("Error copying events from assets: $e");
    }
  }

  void _processEvents(List<dynamic> eventList) {
    final Map<DateTime, List<dynamic>> eventMap = {};

    for (var event in eventList) {
      DateTime eventDate = DateFormat('dd.MM.yyyy').parse(event['date']);
      DateTime normalizedDate = DateTime(eventDate.year, eventDate.month, eventDate.day);

      if (eventMap[normalizedDate] == null) {
        eventMap[normalizedDate] = [];
      }

      // Проверяем, существует ли уже такое событие
      bool eventExists = eventMap[normalizedDate]!.any((existingEvent) =>
          existingEvent['title'] == event['title'] &&
          existingEvent['date'] == event['date']);

      if (!eventExists) {
        eventMap[normalizedDate]!.add(event);
      }
    }

    setState(() {
      _events = eventMap;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
  }

  void _deleteEvent(dynamic event) async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> eventList = jsonDecode(contents);

      eventList.removeWhere((existingEvent) =>
          existingEvent['title'] == event['title'] &&
          existingEvent['date'] == event['date']);

      await file.writeAsString(jsonEncode(eventList));
      _loadEvents(); // Перезагружаем события после удаления
    } catch (e) {
      print("Error deleting event: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents = _events[DateTime(
                    selectedDay.year,
                    selectedDay.month,
                    selectedDay.day,
                  )] ?? [];
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: (day) {
                return _events[DateTime(day.year, day.month, day.day)] ?? [];
              },
            ),
            SizedBox(height: 8.0),
            Text(
              'Events for ${DateFormat('dd.MM.yyyy').format(_selectedDay)}:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            _selectedEvents.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _selectedEvents
                        .map((event) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '- ${event['title'] ?? 'No Title'}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteEvent(event),
                                ),
                              ],
                            ))
                        .toList(),
                  )
                : Text(
                    'No events on this day',
                    style: TextStyle(fontSize: 16),
                  ),
          ],
        ),
      ),
    );
  }
}