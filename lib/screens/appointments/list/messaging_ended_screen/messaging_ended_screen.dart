import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/screens/appointments/list/write_review_filled_screen/write_review_filled_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppointmentsListMessagingEndedScreen extends StatelessWidget {
  AppointmentsModel appointment;
  ContactMethods contactMethod;
  AppointmentsListMessagingEndedScreen(
      {Key? key, required this.appointment, required this.contactMethod}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
                    top: 158,
                    right: 24,
                  ),
                  child: Text(
                    contactMethod == ContactMethods.message
                        ? 'Messaging ended'
                        : contactMethod == ContactMethods.voiceCall
                            ? 'VoiceCall ended'
                            : 'Video call ended',
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
                    top: 16,
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
                        100.00,
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: appointment.img,
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
                    appointment.name,
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
                CustomButton(
                  isDark: isDark,
                  width: size.width,
                  text: "Write a Review",
                  margin: getMargin(
                    left: 24,
                    top: 46,
                    right: 24,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AppointmentsListWriteReviewFilledScreen(
                                contactMethod: contactMethod,
                                appointment: appointment,
                              )),
                    );
                  },
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Main()),
                        (Route<dynamic> route) => false);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: getMargin(
                      left: 24,
                      top: 12,
                      right: 24,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          100.00,
                        ),
                      ),
                      color: ColorConstant.whiteA700,
                    ),
                    child: Center(
                      child: Text(
                        "Go to Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorConstant.blueA400,
                          fontSize: getFontSize(
                            18,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // CustomButton(isDark:isDark,
                    //   width: size.width,
                    //   text: "Go to Dashboard",
                    //   variant: ButtonVariant.OutlineBlueA400,
                    //   alignment: Alignment.centerLeft,
                    // ),
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
