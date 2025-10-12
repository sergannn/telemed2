import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderlivetalkwithItemWidget extends StatelessWidget {
  const SliderlivetalkwithItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(
            left: 83,
            right: 82,
          ),
          child: Text(
            "Live talk with doctor",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: ColorConstant.blueA400,
              fontSize: getFontSize(
                23,
              ),
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: getHorizontalSize(
              368.00,
            ),
            margin: getMargin(
              top: 27,
            ),
            child: Text(
              "Easily connect with doctor, start voice and video call for your better treatment & prescription.",
              maxLines: null,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstant.bluegray800,
                fontSize: getFontSize(
                  16,
                ),
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
