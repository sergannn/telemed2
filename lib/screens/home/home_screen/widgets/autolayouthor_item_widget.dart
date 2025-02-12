import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AutolayouthorItemWidget extends StatelessWidget {
  int index;
  Map<String, dynamic> item;
  AutolayouthorItemWidget({Key? key, required this.index, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: getHorizontalSize(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              getHorizontalSize(
                16.00,
              ),
            ),
            gradient: LinearGradient(
              begin: const Alignment(
                1,
                1.0024292469024658,
              ),
              end: const Alignment(
                0,
                0.0024292469024658203,
              ),
              colors: index == 0 || index % 3 == 0
                  ? [
                      ColorConstant.redA400E5,
                      ColorConstant.pink300E5,
                    ]
                  : index % 3 == 1
                      ? [
                          const Color(0Xff2972FE),
                          const Color(0Xff6499FF),
                        ]
                      : [
                          const Color(0xFFFFB800),
                          const Color(0xFFFFDA7B),
                        ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  left: 20,
                  top: 24,
                  right: 20,
                ),
                child: CommonImageView(
                  svgPath: specialistList[0].img,
                  height: getVerticalSize(
                    40.00,
                  ),
                  width: getHorizontalSize(
                    43.00,
                  ),
                ),
              ),
              Container(
                margin: getMargin(
                  left: 20,
                  top: 22,
                  right: 20,
                ),
                child: Text(
                  item['name'], //specialistList[index].name,
                  //поменял на 1
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontSize: getFontSize(
                      16,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 20,
                  top: 14,
                  right: 20,
                  bottom: 27,
                ),
                child: Text(
                  '${Random().nextInt(100)} Doctors',
//                  "${specialistList[index].noOfDoctors} Doctors",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontSize: getFontSize(
                      14,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
