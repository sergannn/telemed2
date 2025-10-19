import 'dart:developer';

import 'package:doctorq/screens/medcard/add_or_edit_record_form.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/material.dart';

class CreateRecordPage extends StatefulWidget {
  const CreateRecordPage({super.key, this.event, required this.onRecordAdd});
  final CalendarRecordData? event;
  final Function(CalendarRecordData) onRecordAdd;

  @override
  State<CreateRecordPage> createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        leading: IconButton(
          onPressed: context.pop,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        title: Text(
          widget.event == null ? "Создать новую запись" : "Обновить запись",
          style: TextStyle(
            color: const Color.fromARGB(255, 2, 2, 2),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: AddOrEditRecordForm(
            // TODO: Populate the form fields with widget.event data if widget.event != null
            onRecordAdd: (newEvent) {
              widget.onRecordAdd(newEvent);
              Navigator.pop(context, newEvent);
            },
            event: widget.event,
          ),
        ),
      ),
    );
  }
}
