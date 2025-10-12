import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/appointments/steps/step_4_filled_screen/appointments_failed_messaging_dialog/appointments_failed_messaging_dialog.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/bkBtn.dart';
import '../../../../widgets/boxshadow.dart';
import '../../../../widgets/spacing.dart';

// ignore: must_be_immutable
class AppointmentsStep4FilledScreen extends StatelessWidget {
  ContactMethods contactMethod;
  AppointmentsStep4FilledScreen({Key? key, required this.contactMethod}) : super(key: key);
  TextEditingController autoLayoutHorOneController = TextEditingController();

  TextEditingController autoLayoutHorTwoController = TextEditingController();

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
                Container(
                  width: size.width,
                  margin: getMargin(
                    top: 20,
                  ),
                  child: Padding(
                    padding: getPadding(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const BkBtn(),
                        HorizontalSpace(width: 20),
                        Text(
                          "Payment",
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
                VerticalSpace(height: 10),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: getMargin(
                    left: 24,
                    top: 14,
                    right: 24,
                  ),
                  shape: const RoundedRectangleBorder(),
                  child: Container(
                    height: getVerticalSize(
                      240.00,
                    ),
                    width: getHorizontalSize(
                      380.00,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          16.51,
                        ),
                      ),
                      gradient: LinearGradient(
                        begin: const Alignment(
                          1,
                          1.0024292469024658,
                        ),
                        end: const Alignment(
                          0,
                          0.0024292469024658203,
                        ),
                        colors: [
                          ColorConstant.blueA400,
                          ColorConstant.blue300,
                        ],
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: getPadding(
                              left: 14,
                            ),
                            child: CommonImageView(
                              imagePath: ImageConstant.imgVector240X365,
                              height: getVerticalSize(
                                240.00,
                              ),
                              width: getHorizontalSize(
                                365.00,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: getPadding(
                              right: 10,
                            ),
                            child: CommonImageView(
                              imagePath: ImageConstant.imgVector240X263,
                              height: getVerticalSize(
                                240.00,
                              ),
                              width: getHorizontalSize(
                                263.00,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: getVerticalSize(
                              240.00,
                            ),
                            width: getHorizontalSize(
                              299.00,
                            ),
                            margin: getMargin(
                              right: 10,
                            ),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgVector240X299,
                                    height: getVerticalSize(
                                      240.00,
                                    ),
                                    width: getHorizontalSize(
                                      299.00,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: getHorizontalSize(
                                      258.00,
                                    ),
                                    margin: getMargin(
                                      left: 10,
                                      top: 28,
                                      right: 7,
                                      bottom: 28,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            right: 10,
                                          ),
                                          child: Text(
                                            "Mocard",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: ColorConstant.whiteA700,
                                              fontSize: getFontSize(
                                                16.512714385986328,
                                              ),
                                              fontFamily: 'Source Sans Pro',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.66,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 50,
                                          ),
                                          child: Text(
                                            "3827 4637 3103 7389",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: ColorConstant.whiteA700,
                                              fontSize: getFontSize(
                                                27.02080535888672,
                                              ),
                                              fontFamily: 'Source Sans Pro',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.08,
                                              height: 1.00,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                            top: 50,
                                            right: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: getPadding(
                                                  top: 1,
                                                  bottom: 1,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: getPadding(
                                                        right: 10,
                                                      ),
                                                      child: Text(
                                                        "Card Holder name",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .whiteA700,
                                                          fontSize: getFontSize(
                                                            9.006935119628906,
                                                          ),
                                                          fontFamily:
                                                              'Source Sans Pro',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0.36,
                                                          height: 1.00,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: getPadding(
                                                        top: 8,
                                                      ),
                                                      child: Text(
                                                        "Adam Smith",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .whiteA700,
                                                          fontSize: getFontSize(
                                                            15.011558532714844,
                                                          ),
                                                          fontFamily:
                                                              'Source Sans Pro',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 0.60,
                                                          height: 1.00,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(
                                                  left: 52,
                                                  top: 1,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Expiry date",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: ColorConstant
                                                            .whiteA700,
                                                        fontSize: getFontSize(
                                                          9.006935119628906,
                                                        ),
                                                        fontFamily:
                                                            'Source Sans Pro',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0.36,
                                                        height: 1.00,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: getPadding(
                                                        top: 9,
                                                        right: 7,
                                                      ),
                                                      child: Text(
                                                        "02/30",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color: ColorConstant
                                                              .whiteA700,
                                                          fontSize: getFontSize(
                                                            15.011558532714844,
                                                          ),
                                                          fontFamily:
                                                              'Source Sans Pro',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 0.60,
                                                          height: 1.00,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: getPadding(
                              left: 25,
                              top: 30,
                              right: 25,
                              bottom: 30,
                            ),
                            child: CommonImageView(
                              svgPath: ImageConstant.imgAutolayoutver,
                              height: getVerticalSize(
                                179.00,
                              ),
                              width: getHorizontalSize(
                                60.00,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: getMargin(
                    left: 24,
                    top: 24,
                    right: 24,
                  ),
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                2.00,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: getPadding(
                                    left: 24,
                                    top: 1,
                                    right: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 3,
                                        ),
                                        child: Text(
                                          "Full Name",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : ColorConstant.bluegray800A2,
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
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          "*",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: ColorConstant.redA700A2,
                                            fontSize: getFontSize(
                                              14,
                                            ),
                                            fontFamily: 'Source Sans Pro',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: isDark
                                        ? customDarkBoxShadow
                                        : customBoxShadow),
                                child: CustomTextFormField(
                                  isDark: isDark,
                                  width: size.width,
                                  focusNode: FocusNode(),
                                  hintText: "Adam Smith",
                                  margin: getMargin(
                                    top: 11,
                                  ),
                                  fontStyle: TextFormFieldFontStyle
                                      .SourceSansProSemiBold16Gray900a2,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: getMargin(
                    left: 24,
                    top: 24,
                    right: 24,
                  ),
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                2.00,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: getPadding(
                                    left: 24,
                                    top: 1,
                                    right: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "Country",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : ColorConstant.bluegray800A2,
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
                                          bottom: 7,
                                        ),
                                        child: Text(
                                          "*",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: ColorConstant.redA700A2,
                                            fontSize: getFontSize(
                                              14,
                                            ),
                                            fontFamily: 'Source Sans Pro',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: isDark
                                        ? customDarkBoxShadow
                                        : customBoxShadow),
                                child: CustomTextFormField(
                                  isDark: isDark,
                                  width: size.width,
                                  focusNode: FocusNode(),
                                  hintText: "Country",
                                  margin: getMargin(
                                    top: 11,
                                  ),
                                  fontStyle: TextFormFieldFontStyle
                                      .SourceSansProSemiBold16Gray900a2,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 24,
                    top: 24,
                    right: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: getHorizontalSize(
                                  264.00,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      2.00,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: getPadding(
                                          left: 24,
                                          top: 1,
                                          right: 24,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                top: 5,
                                              ),
                                              child: Text(
                                                "Expiary Date",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: ColorConstant
                                                      .bluegray800A2,
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
                                                bottom: 7,
                                              ),
                                              child: Text(
                                                "*",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.redA700A2,
                                                  fontSize: getFontSize(
                                                    14,
                                                  ),
                                                  fontFamily: 'Source Sans Pro',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: isDark
                                              ? customDarkBoxShadow
                                              : customBoxShadow),
                                      child: CustomTextFormField(
                                        isDark: isDark,
                                        width: 264,
                                        focusNode: FocusNode(),
                                        hintText: "Expiary date",
                                        margin: getMargin(
                                          top: 11,
                                        ),
                                        suffix: const Icon(
                                          Icons.calendar_today_rounded,
                                          color: Color(0xFF858C94),
                                        ),
                                        fontStyle: TextFormFieldFontStyle
                                            .SourceSansProSemiBold16Gray900a2,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      HorizontalSpace(width: 16),
                      Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: getHorizontalSize(
                                  100.00,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      2.00,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: getPadding(
                                          left: 24,
                                          top: 1,
                                          right: 24,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: getPadding(
                                                top: 3,
                                              ),
                                              child: Text(
                                                "CVV",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: ColorConstant
                                                      .bluegray800A2,
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
                                                bottom: 5,
                                              ),
                                              child: Text(
                                                "*",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color:
                                                      ColorConstant.redA700A2,
                                                  fontSize: getFontSize(
                                                    14,
                                                  ),
                                                  fontFamily: 'Source Sans Pro',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: isDark
                                              ? customDarkBoxShadow
                                              : customBoxShadow),
                                      child: CustomTextFormField(
                                        isDark: isDark,
                                        width: 100,
                                        focusNode: FocusNode(),
                                        hintText: "CVV",
                                        margin: getMargin(
                                          top: 11,
                                        ),
                                        fontStyle: TextFormFieldFontStyle
                                            .SourceSansProSemiBold16Gray900a2,
                                        textInputAction: TextInputAction.done,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  isDark: isDark,
                  width: size.width,
                  text: "Pay Now",
                  margin: getMargin(
                    left: 20,
                    top: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return LightAppointmentsFailedMessagingDialog(
                          contactMethod: contactMethod,
                        );
                      },
                    );
                  },
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
