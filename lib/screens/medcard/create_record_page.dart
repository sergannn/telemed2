import 'dart:developer';

import 'package:doctorq/screens/medcard/add_or_edit_record_form.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/material.dart';

class CreateRecordPage extends StatefulWidget {
  const CreateRecordPage({
    super.key,
    this.event,
    required this.onRecordAdd,
    this.onRecordDelete,
  });
  final CalendarRecordData? event;
  final Function(CalendarRecordData) onRecordAdd;
  final void Function()? onRecordDelete;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AddOrEditRecordForm(
                onRecordAdd: (newEvent) {
                  widget.onRecordAdd(newEvent);
                  Navigator.pop(context, newEvent);
                },
                event: widget.event,
              ),
              if (widget.event != null && widget.onRecordDelete != null) ...[
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Удалить запись?'),
                        content: Text(
                          'Удалить запись «${widget.event!.title}»?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Удалить'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true && mounted) {
                      widget.onRecordDelete?.call();
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.delete_outline, size: 20),
                  label: const Text('Удалить запись'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
