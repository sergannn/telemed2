import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'base_tool.dart';

class AddCalendarTool extends BaseTool {
  @override
  String get name => 'AddCalendarTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final String action = parameters['action'] as String;
    final String eventTitle = parameters['eventTitle'] as String;
    final String eventDate = parameters['eventDate'] as String;

    // Создаем toolSummary
    final String toolSummary = '<tool_summary>I have provided a generative UI for the user to perform an action $action with event $eventTitle on date $eventDate</tool_summary>';

    // Возвращаем Map с toolWidget и toolSummary
    return {
      'toolWidget': AddCalendarToolWidget(
        action: action,
        eventTitle: eventTitle,
        eventDate: eventDate,
      ),
      'toolSummary': toolSummary,
    };
  }
}

class AddCalendarToolWidget extends StatefulWidget {
  final String action;
  final String eventTitle;
  final String eventDate;

  const AddCalendarToolWidget({
    Key? key,
    required this.action,
    required this.eventTitle,
    required this.eventDate,
  }) : super(key: key);

  @override
  _AddCalendarToolWidgetState createState() => _AddCalendarToolWidgetState();
}

class _AddCalendarToolWidgetState extends State<AddCalendarToolWidget> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  String _feedback = '';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.eventTitle);
    _dateController = TextEditingController(text: widget.eventDate);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_calendar.json');
  }

  Future<List<dynamic>> readEvents() async {
    try {
      // Загружаем данные из assets
      String contents = await rootBundle.loadString('assets/local_calendar.json');
      List<dynamic> events = jsonDecode(contents);

      // Проверяем, существует ли локальный файл, и если да, то читаем его данные
      final file = await _localFile;
      if (await file.exists()) {
        String localContents = await file.readAsString();
        List<dynamic> localEvents = jsonDecode(localContents);
        events.addAll(localEvents);
      }

      return events;
    } catch (e) {
      print('Error reading events: $e');
      return [];
    }
  }

  Future<void> writeEvents(List<dynamic> events) async {
    try {
      final file = await _localFile;
      await file.writeAsString(jsonEncode(events), flush: true);
    } catch (e) {
      print('Error writing events: $e');
    }
  }

  Future<void> _addEvent() async {
    final String title = _titleController.text;
    final String date = _dateController.text;

    // Read existing events
    final List<dynamic> events = await readEvents();

    // Add new event
    final Map<String, String> newEvent = {
      "title": title,
      "date": date,
    };
    events.add(newEvent);

    // Write updated events
    await writeEvents(events);

    setState(() {
      _feedback = 'Event "$title" added on $date';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Event',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter event title',
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'Enter event date',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    // Format and set the date in _dateController
                    String formattedDate = "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
                    _dateController.text = formattedDate;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: widget.action == 'add' ? _addEvent : null,
            child: Text('Add Event'),
          ),
          SizedBox(height: 16.0),
          Text(
            _feedback,
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),
        ],
      ),
    );
  }
}