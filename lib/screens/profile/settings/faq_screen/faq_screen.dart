import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:flutter/material.dart';


import '../../../../widgets/bkBtn.dart';
import '../../../../widgets/spacing.dart';

class ProfileSettingsFaqScreen extends StatefulWidget {
  const ProfileSettingsFaqScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsFaqScreen> createState() =>
      _ProfileSettingsFaqScreenState();
}

class _ProfileSettingsFaqScreenState
    extends State<ProfileSettingsFaqScreen> {

  bool general = true;
  bool account = false;
  bool doctor = false;
  bool cost = false;
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      "FAQ",
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
              child: Column(
                children: [
                    FadeInUp(
                  child: SizedBox(
                  
                    height: getVerticalSize(70),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: getVerticalSize(
                            24.00,
                          ),
                          left: getHorizontalSize(10),
                          right: getHorizontalSize(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                general = true;
                                account = false;
                                doctor = false;
                                cost = false;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(6)),
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  25.50,
                                ),
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  25.50,
                                ),
                                bottom: getVerticalSize(
                                  8.00,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstant.blueA400),
                                color: general
                                    ? ColorConstant.blueA400
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    19.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                "General",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: general
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    16,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                general = false;
                                account = true;
                                doctor = false;
                                cost = false;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(6)),
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  25.50,
                                ),
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  25.50,
                                ),
                                bottom: getVerticalSize(
                                  8.00,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstant.blueA400),
                                color: account
                                    ? ColorConstant.blueA400
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    19.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Account",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: account
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    16,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                general = false;
                                account = false;
                                doctor = true;
                                cost = false;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(6)),
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  25.50,
                                ),
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  25.50,
                                ),
                                bottom: getVerticalSize(
                                  8.00,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstant.blueA400),
                                color: doctor
                                    ? ColorConstant.blueA400
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    19.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Shipping",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: doctor
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    16,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                general = false;
                                account = false;
                                doctor = false;
                                cost = true;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getHorizontalSize(6)),
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  25.50,
                                ),
                                top: getVerticalSize(
                                  8.00,
                                ),
                                right: getHorizontalSize(
                                  25.50,
                                ),
                                bottom: getVerticalSize(
                                  8.00,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstant.blueA400),
                                color: cost
                                    ? ColorConstant.blueA400
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    19.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Cost",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: cost
                                      ? ColorConstant.whiteA700
                                      : ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    16,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (general)
                  FadeInUp(
                    child: Column(
                      children: [
                        Container(
                           margin: getMargin(
                      left: 20,
                      right: 20
                    ),
                          decoration: BoxDecoration(boxShadow:isDark?customDarkBoxShadow: customBoxShadow),
                          child: Accordion(
                            paddingBetweenClosedSections: getVerticalSize(24),
                            paddingBetweenOpenSections: getVerticalSize(24),
                            maxOpenSections: 2,
                            headerBorderRadius: 20,
                            contentBorderColor: ColorConstant.blueA400,
                            contentBorderRadius: 20,
                            contentVerticalPadding: getVerticalSize(24),
                            contentHorizontalPadding: getHorizontalSize(0),
                            rightIcon: Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  31.00,
                                ),
                                right: getHorizontalSize(
                                  30.00,
                                ),
                                left: getHorizontalSize(
                                  30.00,
                                ),
                                bottom: getVerticalSize(
                                  31.00,
                                ),
                              ),
                              child: SizedBox(
                                height: getVerticalSize(
                                  10.00,
                                ),
                                width: getHorizontalSize(
                                  12.00,
                                ),
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: ColorConstant.blueA400,
                                ),
                              ),
                            ),
                            flipRightIconIfOpen: true,
                            headerBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            headerBackgroundColorOpened: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            scaleWhenAnimating: false,
                            openAndCloseAnimation: true,
                            headerPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            sectionOpeningHapticFeedback:
                                SectionHapticFeedback.heavy,
                            sectionClosingHapticFeedback:
                                SectionHapticFeedback.light,
                            contentBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            children: [
                              AccordionSection(
                                isOpen: true,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "How to logout from DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "How to logout from DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "How to logout from DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "How to logout from DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "How to logout from DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "How to logout from DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                        
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(24),
                        )
                      ],
                    ),
                  )
                else if (account)
                  FadeInUp(
                    child: Column(
                      children: [
                        Container(
                           margin: getMargin(
                      left: 20,
                      right: 20
                    ),
                          decoration: BoxDecoration(boxShadow:isDark?customDarkBoxShadow: customBoxShadow),
                          child: Accordion(
                            paddingBetweenClosedSections: getVerticalSize(24),
                            paddingBetweenOpenSections: getVerticalSize(24),
                            maxOpenSections: 2,
                            headerBorderRadius: 20,
                            contentBorderColor: ColorConstant.blueA400,
                            contentBorderRadius: 20,
                            contentVerticalPadding: getVerticalSize(24),
                            contentHorizontalPadding: getHorizontalSize(0),
                            rightIcon: Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  31.00,
                                ),
                                right: getHorizontalSize(
                                  30.00,
                                ),
                                left: getHorizontalSize(
                                  30.00,
                                ),
                                bottom: getVerticalSize(
                                  31.00,
                                ),
                              ),
                              child: SizedBox(
                                height: getVerticalSize(
                                  10.00,
                                ),
                                width: getHorizontalSize(
                                  12.00,
                                ),
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: ColorConstant.blueA400,
                                ),
                              ),
                            ),
                            flipRightIconIfOpen: true,
                            headerBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            headerBackgroundColorOpened: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            scaleWhenAnimating: false,
                            openAndCloseAnimation: true,
                            headerPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            sectionOpeningHapticFeedback:
                                SectionHapticFeedback.heavy,
                            sectionClosingHapticFeedback:
                                SectionHapticFeedback.light,
                            contentBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            children: [
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ is safe for me?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ is safe for me?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ is safe for me?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ is safe for me?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ is safe for me?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ is safe for me?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                           
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(24),
                        )
                      ],
                    ),
                  )
                else if (doctor)
                  FadeInUp(
                    child: Column(
                      children: [
                        Container(
                           margin: getMargin(
                      left: 20,
                      right: 20
                    ),
                          decoration: BoxDecoration(boxShadow:isDark?customDarkBoxShadow: customBoxShadow),
                          child: Accordion(
                            paddingBetweenClosedSections: getVerticalSize(24),
                            paddingBetweenOpenSections: getVerticalSize(24),
                            maxOpenSections: 2,
                            headerBorderRadius: 20,
                            contentBorderColor: ColorConstant.blueA400,
                            contentBorderRadius: 20,
                            contentVerticalPadding: getVerticalSize(24),
                            contentHorizontalPadding: getHorizontalSize(0),
                            rightIcon: Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  31.00,
                                ),
                                right: getHorizontalSize(
                                  30.00,
                                ),
                                left: getHorizontalSize(
                                  30.00,
                                ),
                                bottom: getVerticalSize(
                                  31.00,
                                ),
                              ),
                              child: SizedBox(
                                height: getVerticalSize(
                                  10.00,
                                ),
                                width: getHorizontalSize(
                                  12.00,
                                ),
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: ColorConstant.blueA400,
                                ),
                              ),
                            ),
                            flipRightIconIfOpen: true,
                            headerBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            headerBackgroundColorOpened: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            scaleWhenAnimating: false,
                            openAndCloseAnimation: true,
                            headerPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            sectionOpeningHapticFeedback:
                                SectionHapticFeedback.heavy,
                            sectionClosingHapticFeedback:
                                SectionHapticFeedback.light,
                            contentBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            children: [
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "What is DoctorQ?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(24),
                        )
                      ],
                    ),
                  )
                else if (cost)
                  FadeInUp(
                    child: Column(
                      children: [
                        Container(
                           margin: getMargin(
                      left: 20,
                      right: 20
                    ),
                          decoration: BoxDecoration(boxShadow:isDark?customDarkBoxShadow: customBoxShadow),
                          child: Accordion(
                            paddingBetweenClosedSections: getVerticalSize(24),
                            paddingBetweenOpenSections: getVerticalSize(24),
                            maxOpenSections: 2,
                            headerBorderRadius: 20,
                            contentBorderColor: ColorConstant.blueA400,
                            contentBorderRadius: 20,
                            contentVerticalPadding: getVerticalSize(24),
                            contentHorizontalPadding: getHorizontalSize(0),
                            rightIcon: Padding(
                              padding: EdgeInsets.only(
                                top: getVerticalSize(
                                  31.00,
                                ),
                                right: getHorizontalSize(
                                  30.00,
                                ),
                                left: getHorizontalSize(
                                  30.00,
                                ),
                                bottom: getVerticalSize(
                                  31.00,
                                ),
                              ),
                              child: SizedBox(
                                height: getVerticalSize(
                                  10.00,
                                ),
                                width: getHorizontalSize(
                                  12.00,
                                ),
                                child: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: ColorConstant.blueA400,
                                ),
                              ),
                            ),
                            flipRightIconIfOpen: true,
                            headerBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            headerBackgroundColorOpened: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            scaleWhenAnimating: false,
                            openAndCloseAnimation: true,
                            headerPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            sectionOpeningHapticFeedback:
                                SectionHapticFeedback.heavy,
                            sectionClosingHapticFeedback:
                                SectionHapticFeedback.light,
                            contentBackgroundColor: isDark
                                ? ColorConstant.darkTextField
                                : ColorConstant.whiteA700,
                            children: [
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ free to use?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ free to use?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ free to use?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ free to use?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ free to use?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                              AccordionSection(
                                isOpen: false,
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          24.00,
                                        ),
                                        right: getHorizontalSize(
                                          24.00,
                                        ),
                                        top: getVerticalSize(
                                          25.21,
                                        ),
                                        bottom: getVerticalSize(
                                          25.20,
                                        ),
                                      ),
                                      child: Text(
                                        "Is DoctorQ free to use?",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            18,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getHorizontalSize(24)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                      Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        maxLines: null,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                           
                          
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(24),
                        )
                      ],
                    ),
                  )
              
              
                ],
              ),
            ),
          )
          ],
        ),
      ),
    );
  }
}
