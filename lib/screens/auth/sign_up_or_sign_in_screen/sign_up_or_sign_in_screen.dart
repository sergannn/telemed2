import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/doctor_screen.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:doctorq/screens/auth/sign_up_blank_screen/sign_up_blank_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignUpOrSignInScreen extends StatelessWidget {
  const SignUpOrSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: getPadding(left: 24, right: 24),
              child: SizedBox(
                height: getVerticalSize(350),
                width: size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConstant.logoDecoration,
                      height: getVerticalSize(350),
                      width: size.width,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.appLogo,
                            height: getVerticalSize(140),
                            width: getHorizontalSize(140),
                          ),
                          Text(
                            "DoctorQ",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.blueA400,
                              fontSize: getFontSize(
                                44.418983459472656,
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
                top: 98,
                right: 24,
              ),
              child: Text(
                "Welcome to DoctorQ!",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: getFontSize(
                    23,
                  ),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomButton(
              isDark: isDark,
              width: size.width,
              text: "Sign Up",
              margin: getMargin(
                left: 24,
                top: 93,
                right: 24,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpBlankScreen()),
                );
              },
              fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
            ),
            CustomButton(
              isDark: isDark,
              width: size.width,
              text: "Sign In",
              margin: getMargin(
                left: 24,
                top: 12,
                right: 24,
                bottom: 20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInBlankScreen()),
                );
              },
              variant: ButtonVariant.OutlineBlueA400,
            ),
          ],
        ),
      ),
    );
  }
}
