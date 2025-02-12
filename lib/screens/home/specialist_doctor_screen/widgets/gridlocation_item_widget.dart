import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridlocationItemWidget extends StatelessWidget {
  int index;
  List<SpecialistModel> items;
  GridlocationItemWidget({Key? key, required this.index, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var specialistList = items;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: getHorizontalSize(180),
        height: getVerticalSize(157),
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
                left: 24,
                top: 24,
                right: 24,
              ),
              child: CommonImageView(
                svgPath: specialistList[index].img,
                height: getVerticalSize(
                  40.00,
                ),
                width: getHorizontalSize(
                  43.00,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 24,
                top: 21,
                right: 24,
              ),
              child: Text(
                specialistList[index].name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
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
                left: 24,
                top: 13,
                right: 24,
                bottom: 0,
              ),
              child: Text(
                "${specialistList[index].noOfDoctors} Doctors",
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
    );
  }
}
