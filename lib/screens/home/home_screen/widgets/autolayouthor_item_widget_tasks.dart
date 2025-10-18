import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetTasks extends StatelessWidget {
  int index;
//  Map<String, dynamic> item;
  dynamic item;
  AutolayouthorItemWidgetTasks(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Если это прием, переходим к экрану приема
        if (item.category == 'Приемы' && item.description != null && item.description.contains('ID:')) {
          // Извлекаем ID приема из description
          String appointmentId = item.description.replaceAll('ID: ', '');
          print("DEBUG: Navigating to appointment with ID: $appointmentId");
          
          // Здесь можно добавить навигацию к экрану приема
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailScreen(appointmentId: appointmentId)));
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
                  text: '${getCategoryName(item.category)}\n',
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
  if (record.category == 'Cat1' || record.category == 'Приемы') {
    return Color.fromARGB(255, 138, 234, 205);
  } else if (record.category == 'Cat2') {
    return ColorConstant.fromHex("C8E0FF");
  } else if (record.category == 'Cat3') {
    return ColorConstant.fromHex("FFFCBB");
  } else if (record.category == 'Пусто') {
    return ColorConstant.fromHex("FFFCBB");
  } else {
    return Color.fromARGB(255, 138, 234, 205);
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
