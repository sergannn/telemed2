import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/custom_switch.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

class ProfileSettingsSecurityScreen extends StatefulWidget {
  const ProfileSettingsSecurityScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsSecurityScreen> createState() =>
      _ProfileSettingsSecurityScreenState();
}

class _ProfileSettingsSecurityScreenState
    extends State<ProfileSettingsSecurityScreen> {
  bool switchVal1 = true;
  bool switchVal2 = true;
  bool switchVal3 = false;
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
                      "Security",
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
                                    "Face ID",
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
                                    "Remember me",
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
                                    setState(() {
                                      switchVal2 = !switchVal2;
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
                                    "Touch ID",
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
