import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/custom_switch.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

class ProfileSettingsNotificationScreen extends StatefulWidget {
  const ProfileSettingsNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsNotificationScreen> createState() =>
      _ProfileSettingsNotificationScreenState();
}

class _ProfileSettingsNotificationScreenState
    extends State<ProfileSettingsNotificationScreen> {
  bool switchVal1 = true;
  bool switchVal2 = true;
  bool switchVal3 = false;
  bool switchVal4 = false;

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
              margin: getMargin(top: 35, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BkBtn(),
                  HorizontalSpace(width: 20),
                  Text(
                    "Notification",
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(
                    top: 34,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            switchVal1 = !switchVal1;
                          });
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: getPadding(
                                left: 24, right: 24, top: 10, bottom: 10),
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
                                    "Sound",
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
                                  value: switchVal1,
                                  onChanged: (value) {
                                    setState(() {
                                      switchVal1 = !switchVal1;
                                    });
                                  },
                                ),
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
                      InkWell(
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
                                    top: 8,
                                    bottom: 7,
                                  ),
                                  child: Text(
                                    "Vibrate",
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
                                  onChanged: (value) {
                                    switchVal2 = !switchVal2;
                                    setState(() {});
                                  },
                                ),
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
                      InkWell(
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
                                    top: 9,
                                    bottom: 6,
                                  ),
                                  child: Text(
                                    "New tips available",
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
                                    switchVal3 = !switchVal3;
                                    setState(() {});
                                  },
                                ),
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
                          top: 24,
                          right: 24,
                        ),
                        child: CustomDivider(isDark: isDark),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            switchVal4 = !switchVal4;
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
                                    "New service available",
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
                                  value: switchVal4,
                                  onChanged: (value) {
                                    switchVal4 = !switchVal4;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
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
