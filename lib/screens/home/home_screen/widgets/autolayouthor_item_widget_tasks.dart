import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetTasks extends StatelessWidget {
  int index;
  CalendarRecordData item;
  final void Function(CalendarRecordData record, {CalendarRecordData? oldRecord})? onRecordSaved;
  final void Function(CalendarRecordData record)? onRecordDelete;
  final VoidCallback? onReturnFromDiary;

  AutolayouthorItemWidgetTasks({
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
              debugPrint('>>> DELETE longPress: dialog open "${item.title}"');
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Удалить?'),
                  content: Text('Удалить запись «${item.title}»?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        debugPrint('>>> DELETE: user tapped Отмена');
                        Navigator.pop(ctx, false);
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        debugPrint('>>> DELETE: user tapped Удалить');
                        Navigator.pop(ctx, true);
                      },
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
              );
              debugPrint('>>> DELETE: dialog result confirm=$confirm mounted=${context.mounted} onRecordDelete=${onRecordDelete != null}');
              if (confirm == true && context.mounted) {
                if (onRecordDelete == null) {
                  debugPrint('>>> DELETE: ERROR onRecordDelete is NULL!');
                } else {
                  debugPrint('>>> DELETE: calling onRecordDelete for "${item.title}"');
                  onRecordDelete!(item);
                }
              }
            },
      onTap: () {
        print(item);
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
          // print("DEBUG: Navigating to create record screen (Doctor)");
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => CreateRecordPage(
          //     event: null,
          //     onRecordAdd: (record) {
          //       onRecordSaved?.call(record, oldRecord: null);
          //       print("DEBUG: Record updated: ${record.title}");
          //     },
          //   ),
          // ));
        } else if ((item.category == 'Приемы' || item.category == 'Предстоящие сеансы') && item.description != null
            && item.description!.contains('ID:')) {
          // Если в блоке отображен предстоящий сеанс - переход к предстоящим сеансам
          print("DEBUG: Navigating to upcoming appointments (Doctor)");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsScreen(),
            ),
          );
        } else {
          // Редактирование существующей записи
          print("DEBUG: Navigating to edit record screen (Doctor)");
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(8.0), // Отступы
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Внутренние отступы
            decoration: BoxDecoration(
              color: ColorConstant.fromHex("FFFFFF").withAlpha(400),
              borderRadius: BorderRadius.circular(20.0), // Радиус для овала
            ),
            child: Text(
              '${item.date.day}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: RichText(
                text: TextSpan(
                  text: (item.title.isNotEmpty ? item.title : "Онлайн прием") + '\n',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: getCategoryName(item.category),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.all(8.0), // Отступы
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Внутренние отступы
            decoration: BoxDecoration(
              color: ColorConstant.fromHex("FFFFFF").withAlpha(400),
              borderRadius: BorderRadius.circular(20.0), // Радиус для овала
            ),
            child: Text(
              "20:00",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
