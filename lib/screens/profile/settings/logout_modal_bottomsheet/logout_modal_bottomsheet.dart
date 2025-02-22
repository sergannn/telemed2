import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/doctor_screen.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_login_yandex/flutter_login_yandex.dart';
import 'package:flutter_login_yandex_updated/flutter_login_yandex.dart';

// ignore_for_file: must_be_immutable
class ProfileSettingsLogoutModalBottomsheet extends StatelessWidget {
  const ProfileSettingsLogoutModalBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _flutterLoginYandexPlugin = FlutterLoginYandex();
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              getHorizontalSize(
                40.00,
              ),
            ),
            topRight: Radius.circular(
              getHorizontalSize(
                40.00,
              ),
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
                top: 8,
                right: 24,
              ),
              child: CommonImageView(
                svgPath: ImageConstant.imgFrame,
                height: getVerticalSize(
                  3.00,
                ),
                width: getHorizontalSize(
                  38.00,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 24,
                top: 37,
                right: 24,
              ),
              child: Image.asset(
                ImageConstant.logout,
                color: ColorConstant.blueA400,
                height: getSize(
                  48.00,
                ),
                width: getSize(
                  48.00,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 24,
                top: 30,
                right: 24,
              ),
              child: Text(
                "Are you sure want to logout?",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
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
                top: 38,
                right: 24,
                bottom: 48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomButton(
                    isDark: isDark,
                    width: 184,
                    text: "Cancel",
                    onTap: () {
                      Navigator.pop(context);
                    },
                    variant: ButtonVariant.OutlineBlueA400,
                  ),
                  HorizontalSpace(width: 11),
                  CustomButton(
                    isDark: isDark,
                    width: 184,
                    text: "Yes, Logout",
                    onTap: () async {
                      final response =
                          await _flutterLoginYandexPlugin.signOut();
                      print(response);

                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SignInBlankScreen()),
                              (Route<dynamic> route) => false);
                    },
                    fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
