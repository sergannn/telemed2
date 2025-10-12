import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/custom_switch.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';

import '../../../../utils/pub.dart';

class ProfileSettingsAppearanceScreen extends StatefulWidget {
  const ProfileSettingsAppearanceScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsAppearanceScreen> createState() =>
      _ProfileSettingsAppearanceScreenState();
}

class _ProfileSettingsAppearanceScreenState
    extends State<ProfileSettingsAppearanceScreen> {
  bool switchVal2 = true;
  bool switchVal3 = true;
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
                      "Визуальные настройки",
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
                    top: 31,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: getPadding(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: getPadding(
                                  top: 8,
                                  bottom: 7,
                                ),
                                child: Text(
                                  "Темный режим",
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
                              CustomSwitch(
                                value: themeManager.themeMode == ThemeMode.dark,
                                onChanged: (value) {
                                  setState(() {});
                                  themeManager.toggleTheme(value);
                                },
                              ),
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
                      /*  InkWell(
                        onTap: () {
                          setState(() {
                            switchVal2 = !switchVal2;
                          });
                        },
                        child: Align(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                 Padding(
                                  padding: getPadding(
                                    top: 10,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    "Doctor?",
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
                                CustomSwitch(
                                  value: switchVal2,
                                  onChanged: (value) async {
                                    await changeRole(value);
                                    setState(() {
                                      switchVal2 = !switchVal2;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),*/
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
                      /*InkWell(
                        onTap: () {
                          setState(() {
                            switchVal3 = !switchVal3;
                          });
                        },
                        child: Align(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    top: 8,
                                    bottom: 7,
                                  ),
                                  child: Text(
                                    "Full Screen Mode",
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
                                CustomSwitch(
                                  value: switchVal3,
                                  onChanged: (value) {
                                    setState(() {
                                      switchVal3 = !switchVal3;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),*/
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
