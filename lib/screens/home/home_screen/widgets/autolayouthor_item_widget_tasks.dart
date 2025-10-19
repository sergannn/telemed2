import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetTasks extends StatelessWidget {
  int index;
  dynamic item; // Изменяем тип на dynamic для поддержки CalendarRecordData
  AutolayouthorItemWidgetTasks(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item['category'] == 'Приемы' && item['description'] != null && item['description'].toString().contains('ID:')) {
          // Если в блоке отображен предстоящий сеанс - переход к предстоящим сеансам
          print("DEBUG: Navigating to upcoming appointments (Doctor)");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsScreen(),
            ),
          );
        } else {
          // Если в блоке НЕ отображен сеанс - переход к экрану "Обновить запись" (как при двойном клике на дату в календаре)
          print("DEBUG: Navigating to edit record screen (Doctor)");
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateRecordPage(
                event: item, // Передаем существующую запись для редактирования
                onRecordAdd: (record) {
                  // Обновляем календарь после редактирования записи
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
        color: index % 2 == 0
            ? ColorConstant.fromHex("C8E0FF")
            : ColorConstant.fromHex("FFFCBB"),
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
              item['date'] != null ? 
                DateTime.parse(item['date']).day.toString() : 
                "26",
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
                  text: (item['title'] ?? "Онлайн прием") + '\n',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: item['category'] ?? 'Врач аллерголог',
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
