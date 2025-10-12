import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderchatwithdoctoItemWidget extends StatelessWidget {
  const SliderchatwithdoctoItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(
            left: 95,
            right: 94,
          ),
          child: Text(
            "Chat with doctors",
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
              365.00,
            ),
            margin: getMargin(
              top: 28,
            ),
            child: Text(
              "Book an appointment with doctor. Chat with doctor via appointment letter and get consultation.",
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
