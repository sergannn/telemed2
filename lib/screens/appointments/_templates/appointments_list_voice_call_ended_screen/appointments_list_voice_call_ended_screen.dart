import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AppointmentsListVoiceCallEndedScreen extends StatelessWidget {
  const AppointmentsListVoiceCallEndedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
       body:SafeArea(
          child:
           SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 156,
                    right: 24,
                  ),
                  child: Text(
                    "Voice Call Ended",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorConstant.gray900A2,
                      fontSize: getFontSize(
                        18,
                      ),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 18,
                    right: 24,
                  ),
                  child: Text(
                    "30:00 Minutes",
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
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 19,
                    right: 24,
                  ),
                  child: Text(
                    "Recordings have been saved in history",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: ColorConstant.gray900A2,
                      fontSize: getFontSize(
                        16,
                      ),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 44,
                    right: 24,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        94.00,
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: ImageConstant.imgImage5,
                      height: getSize(
                        188.00,
                      ),
                      width: getSize(
                        188.00,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 27,
                    right: 24,
                  ),
                  child: Text(
                    "Dr. Albert Flores",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        
                      fontSize: getFontSize(
                        26,
                      ),
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomButton(isDark:isDark,
                  width: 380,
                  text: "\"Write a Review\"",
                  margin: getMargin(
                    left: 24,
                    top: 46,
                    right: 24,
                  ),
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                ),
                Container(
                  width: double.infinity,
                  margin: getMargin(
                    left: 24,
                    top: 12,
                    right: 24,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.whiteA700,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButton(isDark:isDark,
                        width: 380,
                        text: "\"Go to Dashboard\"",
                        variant: ButtonVariant.OutlineBlueA400,
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
