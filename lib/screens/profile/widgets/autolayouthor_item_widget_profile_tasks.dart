import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

const String _kEmptyDayPlaceholderTitleProfile = 'Попробуйте воспользоваться дневником';

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

  bool get _isPlaceholder => item.title == _kEmptyDayPlaceholderTitleProfile;
  bool get _isAppointment => isAppointmentCategory(item.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _isPlaceholder || _isAppointment
          ? null
          : () async {
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
              if (confirm == true && context.mounted) {
                print('DEBUG AutolayouthorItemWidgetProfileTasks: onRecordDelete called for "${item.title}"');
                onRecordDelete?.call(item);
              }
            },
      onTap: () {
        if (_isPlaceholder) {
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
        } else if ((item.category == 'Приемы' || item.category == 'Предстоящие сеансы') && item.description != null && item.description!.contains('ID:')) {
          print("DEBUG: Navigating to upcoming appointments");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsScreen(),
            ),
          );
        } else {
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
          ).then((_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onReturnFromDiary?.call();
            });
          });
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
        color: getCategoryColorLib(item.category),
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
                      text: '\n'+_getCategoryName(item.category),
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

String _getCategoryName(String? category) {
  switch (category) {
    case 'Cat1':
    case 'Приемы':
      return 'Приемы';
    case 'Cat2':
    case 'Лекарства':
      return 'Лекарства';
    case 'Cat3':
    case 'Упражнения':
      return 'Упражнения';
    case 'Пусто':
    case 'Пусто2':
    case 'Пусто3':
      return 'Дневник';
    default:
      return category ?? 'Запись';
  }
}
