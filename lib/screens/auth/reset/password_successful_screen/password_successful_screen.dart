import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';


class ResetPasswordSuccessfulScreen extends StatelessWidget {
  const ResetPasswordSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VerticalSpace(height: 20),
              Column(
                children: [
                  Padding(
                    padding: getPadding(left: 24, right: 24, top: 24),
                    child: SizedBox(
                      height: getVerticalSize(190),
                      width: getHorizontalSize(200),
                      child: Stack(
                        children: [
                          Image.asset(
                            ImageConstant.logoDecoration,
                            height: getVerticalSize(190),
                            width: getHorizontalSize(200),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageConstant.appLogo,
                                  height: getVerticalSize(80),
                                  width: getHorizontalSize(80),
                                ),
                                Text(
                                  "DoctorQ",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.blueA400,
                                    fontSize: getFontSize(
                                      25,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 24,
                      top: 35,
                      right: 24,
                    ),
                    child: Text(
                      "Congrats!",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorConstant.blueA400,
                        fontSize: getFontSize(
                          32,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
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
                      "Your account is ready to use",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getFontSize(
                          18,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              CustomButton(
                isDark: isDark,
                width: size.width,
                text: "Go to homepage",
                margin: getMargin(
                  left: 24,
                  right: 24,
                  bottom: 20,
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Main()),
                      (Route<dynamic> route) => false);
                },
                fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
