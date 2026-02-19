import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetProfileTasks extends StatelessWidget {
  int index;
  CalendarRecordData item;
  final void Function(CalendarRecordData record, {CalendarRecordData? oldRecord})? onRecordSaved;
  final void Function(CalendarRecordData record)? onRecordDelete;
  final VoidCallback? onReturnFromDiary;

  AutolayouthorItemWidgetProfileTasks({
    Key? key,
    required this.index,
    required this.item,
    this.onRecordSaved,
    this.onRecordDelete,
    this.onReturnFromDiary,
  }) : super(key: key);

  bool get _isPlaceholder => item.title == kEmptyDayPlaceholderTitle;
  bool get _isAppointment => isAppointmentCategory(item.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _isPlaceholder || _isAppointment
          ? null
          : () async {
              debugPrint('>>> DELETE profile longPress: dialog open "${item.title}"');
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Удалить?'),
                  content: Text('Удалить запись «${item.title}»?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
              );
              debugPrint('>>> DELETE profile: dialog result confirm=$confirm onRecordDelete=${onRecordDelete != null}');
              if (confirm == true && context.mounted) {
                if (onRecordDelete != null) {
                  debugPrint('>>> DELETE profile: calling onRecordDelete for "${item.title}"');
                  onRecordDelete!(item);
                } else {
                  debugPrint('>>> DELETE profile: ERROR onRecordDelete is NULL');
                }
              }
            },
      onTap: () {
        if (_isPlaceholder) {
          // Заглушка "На этот день заметки отсутствуют" → переход в экран дневника (с AppBar и вкладками)
          print("DEBUG: Navigating to diary (MedCardScreen, tab Дневник)");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MedCardScreen(initialTabIndex: 2),
            ),
          ).then((_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onReturnFromDiary?.call();
            });
          });
          // Ранее: открывалось окно создания новой записи (CreateRecordPage)
          // print("DEBUG: Navigating to create record screen");
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => CreateRecordPage(
          //     event: null,
          //     onRecordAdd: (record) {
          //       onRecordSaved?.call(record, oldRecord: null);
          //       print("DEBUG: Record updated: ${record.title}");
          //     },
          //   ),
          // ));
        } else if ((item.category == 'Приемы' || item.category == 'Предстоящие сеансы') && item.description != null && item.description!.contains('ID:')) {
          // Если это прием, переходим к экрану приема
          String appointmentId = item.description!.replaceAll('ID: ', '');
          print("DEBUG: Navigating to appointment with ID: $appointmentId");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsScreen(),
            ),
          );
        } else {
          // Редактирование существующей записи
          print("DEBUG: Navigating to edit record screen");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateRecordPage(
                event: item,
                onRecordAdd: (record) {
                  onRecordSaved?.call(record, oldRecord: item);
                  print("DEBUG: Record updated: ${record.title}");
                },
              ),
            ),
          );
        }
      },
      child: Container(
      width: MediaQuery.of(context).size.width / 3,
      //height: getVerticalSize(10.0), // Установили фиксированную высоту
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        ),
        color: getCategoryColor(item.category),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.all(0.5),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.5),
            child: Icon(
              Icons.calendar_today,
              color: Colors.black,
              size: 18.0,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.5),
              child: RichText(
                text: TextSpan(
                  text: item.title.isNotEmpty ? item.title : "Записи" + '\n',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n'+getCategoryName(item.category),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.all(0.5), // Отступы
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 0.5), // Внутренние отступы

          ),
        ],
      ),
    ),
    );
  }
}
