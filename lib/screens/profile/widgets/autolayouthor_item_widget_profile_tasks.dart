import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/screens/medcard/create_record_page.dart';
import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetProfileTasks extends StatelessWidget {
  int index;
  CalendarRecordData item;
  AutolayouthorItemWidgetProfileTasks(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((item.category == 'Приемы' || item.category == 'Предстоящие сеансы') && item.description != null && item.description!.contains('ID:')) {
          // Если это прием, переходим к экрану приема
          String appointmentId = item.description!.replaceAll('ID: ', '');
          print("DEBUG: Navigating to appointment with ID: $appointmentId");
          
          // Навигация к экрану приема
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentsScreen(), // Убираем mode: 'old' для предстоящих сеансов
            ),
          );
        } else {
          // Если в блоке НЕ отображен сеанс - переход к экрану "Обновить запись" (как при двойном клике на дату в дневнике)
          print("DEBUG: Navigating to edit record screen");
          
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
      //height: getVerticalSize(10.0), // Установили фиксированную высоту
      
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
                      text: item.category ?? '2 записи',
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
