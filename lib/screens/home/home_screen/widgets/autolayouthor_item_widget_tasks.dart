import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidgetTasks extends StatelessWidget {
  int index;
  Map<String, dynamic> item;
  AutolayouthorItemWidgetTasks(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              "Чт. 26",
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
                  text: "Онлайн прием" + '\n',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '3 близких',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
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
    );
  }
}
