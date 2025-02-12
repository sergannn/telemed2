import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/profile/settings/faq_screen/faq_screen.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileSettingsHelpScreen extends StatelessWidget {
  bool checkbox = false;

  ProfileSettingsHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(
                top: 36,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BkBtn(),
                    HorizontalSpace(width: 20),
                    Text(
                      "Help",
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(
                    top: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileSettingsFaqScreen()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: getPadding(
                                left: 24, right: 24, bottom: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    top: 6,
                                    bottom: 1,
                                  ),
                                  child: Text(
                                    "FAQ",
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
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: ColorConstant.blueA400,
                                  size: getSize(20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        margin: getMargin(
                          left: 24,
                          top: 10,
                          bottom: 10,
                          right: 24,
                        ),
                        child: CustomDivider(isDark: isDark),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 24,
                            top: 10,
                            bottom: 10,
                            right: 24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 4,
                                  bottom: 3,
                                ),
                                child: Text(
                                  "Contact us",
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
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorConstant.blueA400,
                                size: getSize(20),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        width: getHorizontalSize(
                          380.00,
                        ),
                        margin: getMargin(
                          left: 24,
                          top: 10,
                          bottom: 10,
                          right: 24,
                        ),
                        child: CustomDivider(isDark: isDark),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 24,
                            top: 10,
                            bottom: 10,
                            right: 24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 5,
                                  bottom: 2,
                                ),
                                child: Text(
                                  "Terms & Conditions",
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
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorConstant.blueA400,
                                size: getSize(20),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: getVerticalSize(
                          1.00,
                        ),
                        margin: getMargin(
                          left: 24,
                          top: 10,
                          bottom: 10,
                          right: 24,
                        ),
                        child: CustomDivider(isDark: isDark),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 24,
                            top: 10,
                            bottom: 10,
                            right: 24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 5,
                                  bottom: 2,
                                ),
                                child: Text(
                                  "Privay Policy",
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
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ColorConstant.blueA400,
                                size: getSize(20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
