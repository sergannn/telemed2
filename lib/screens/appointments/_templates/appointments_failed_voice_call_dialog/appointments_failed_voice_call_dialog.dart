import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AppointmentsFailedVoiceCallDialog extends StatelessWidget {
  const AppointmentsFailedVoiceCallDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
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
              top: 32,
              right: 24,
            ),
            child: CommonImageView(
              svgPath: ImageConstant.imgGroup4,
              height: getVerticalSize(
                192.00,
              ),
              width: getHorizontalSize(
                199.00,
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              left: 24,
              top: 34,
              right: 24,
            ),
            child: Text(
              "Oops, Failed",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: ColorConstant.redA400,
                fontSize: getFontSize(
                  29,
                ),
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: getHorizontalSize(
              242.00,
            ),
            margin: getMargin(
              left: 24,
              top: 19,
              right: 24,
            ),
            child: Text(
              "Please make sure that your internet connection is active and stable, then press “Try Again”",
              maxLines: null,
              textAlign: TextAlign.center,
              style: TextStyle(
                  
                fontSize: getFontSize(
                  16,
                ),
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomButton(isDark:isDark,
            width: 272,
            text: "\"Try Again\"",
            margin: getMargin(
              left: 24,
              top: 26,
              right: 24,
              bottom: 20,
            ),
            shape: ButtonShape.CircleBorder24,
            fontStyle: ButtonFontStyle.SourceSansProSemiBold16WhiteA700,
          ),
        ],
      ),
    );
  }
}
