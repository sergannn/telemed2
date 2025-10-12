import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetProfileTasks extends StatelessWidget {
  int index;
  Map<String, dynamic> item;
  AutolayouthorItemWidgetProfileTasks(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                text: const TextSpan(
                  //item['name'] +
                  text: "Записи" + '\n',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '2 записи',
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
    );
  }
}
