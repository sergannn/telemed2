import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:flutter/material.dart';

// Заглушка для дня без записей (тап открывает создание, а не редактирование)
const String _kEmptyDayPlaceholderTitle = 'Попробуйте воспользоваться дневником';

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

  bool get _isPlaceholder => item.title == _kEmptyDayPlaceholderTitle;
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
                print('DEBUG AutolayouthorItemWidgetTasks: onRecordDelete called for "${item.title}"');
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
          print("DEBUG: Navigating to appointment with ID: ${item.description!.replaceAll('ID: ', '')}");
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              16.00,
            ),
          ),
          color: getColor(
              item) /*index % 2 == 0
            ? ColorConstant.fromHex("C8E0FF")
            : ColorConstant.fromHex("FFFCBB"),*/
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Text(item.toString()),
          Container(
            margin: EdgeInsets.all(8.0), // Отступы
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Внутренние отступы
            decoration: BoxDecoration(
              color: ColorConstant.fromHex("FFFFFF").withAlpha(400),
              borderRadius: BorderRadius.circular(20.0), // Радиус для овала
            ),
            child: Text(
              //   item.date.toString(),
              "${_getShortWeekday(item.date.weekday)}. ${item.date.day}",

              //  "Чт. 26",
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
                  //item['name'] +
                  text: '${getCategoryName(item.category ?? '')}\n',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: item.title,
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

Color getColor(dynamic record) {
  // Цвета: голубоватый, желтоватый, нежно-розовый
  if (record.category == 'Cat1' || record.category == 'Приемы' || record.category == 'Предстоящие сеансы') {
    return ColorConstant.fromHex("C8E0FF"); // голубоватый
  } else if (record.category == 'Cat2' || record.category == 'Лекарства') {
    return ColorConstant.fromHex("FFFCBB"); // желтоватый
  } else if (record.category == 'Cat3' || record.category == 'Упражнения') {
    return ColorConstant.fromHex("FFD6E0"); // нежно-розовый
  } else if (record.category == 'Пусто') {
    return ColorConstant.fromHex("C8E0FF"); // голубоватый по умолчанию
  } else {
    return ColorConstant.fromHex("C8E0FF"); // голубоватый по умолчанию
  }
}

String getCategoryName(String category) {
  switch (category) {
    case 'Cat1':
      return 'Приемы';
    case 'Cat2':
      return 'Лекарства';
    case 'Cat3':
      return 'Упражнения';
    case 'Приемы':
      return 'Приемы';
    case 'Пусто':
      return 'Дневник';
    default:
      return 'Дневник';
  }
}

String _getShortWeekday(int weekday) {
  const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  return weekdays[weekday - 1];
}
