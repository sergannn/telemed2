import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/auth/forgot/password_otp_active_screen/guess_code_screen.dart';
import 'package:doctorq/screens/auth/reset/password_screen/password_screen.dart';
import 'package:doctorq/screens/profile/blank_screen/blank_screen.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/services/auth_service.dart';

class ForgotPasswordOtpActiveScreen extends StatelessWidget {
  final dynamic response;
  late dynamic code;
  ForgotPasswordOtpActiveScreen({Key? key, this.response}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: size.width,
                  margin: getMargin(top: 36, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const BkBtn(),
                      HorizontalSpace(width: 20),
                      Text(
                        "Регистрация",
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
              Column(
                children: [
                  Padding(
                    padding: getPadding(
                      left: 24,
                      right: 24,
                      top: 40,
                    ),
                    child: Text(
                      "Код подтверждения был выслан на email /sms \n" +
                          response.toString()
                      //   context.userData['email']
                      ,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
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
                      top: 63,
                      right: 24,
                    ),
                    child: SizedBox(
                      width: size.width,
                      height: getVerticalSize(
                        90.00,
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.number,
                        autoDismissKeyboard: true,
                        enableActiveFill: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {},
                        textStyle: TextStyle(
                          fontSize: getFontSize(
                            29,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                        pinTheme: PinTheme(
                          fieldHeight: getHorizontalSize(
                            68.00,
                          ),
                          fieldWidth: getHorizontalSize(
                            83.00,
                          ),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              20.00,
                            ),
                          ),
                          selectedFillColor: isDark
                              ? ColorConstant.darkTextField
                              : ColorConstant.whiteA700,
                          activeFillColor: isDark
                              ? ColorConstant.darkTextField
                              : ColorConstant.whiteA700,
                          inactiveFillColor: isDark
                              ? ColorConstant.darkTextField
                              : ColorConstant.whiteA700,
                          inactiveColor: isDark
                              ? ColorConstant.darkBottomSheet
                              : ColorConstant.fromHex("#1212121D"),
                          selectedColor: ColorConstant.blueA400,
                          activeColor: isDark
                              ? ColorConstant.darkBottomSheet
                              : ColorConstant.fromHex("#1212121D"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: getMargin(
                      left: 24,
                      top: 14,
                      right: 24,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Повторная отправка кода через",
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: " 56",
                            style: TextStyle(
                              color: ColorConstant.blueA400,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: " с",
                            style: TextStyle(
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Не получили код? Проверьте спам"),
                  SizedBox(height: 20),
                  CustomButton(
                    isDark: isDark,
                    width: size.width,
                    text: "Подтвердить",
                    /*margin: getMargin(
                  left: 24,
                  right: 24,
                  bottom: 20,
                ),*/
                    onTap: () {
                      showDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          Future.delayed(const Duration(milliseconds: 600), () {
                            Navigator.of(context).pop(true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuessCodeScreen()
                                  //   const GuessCode()
                                  //     const ProfileBlankScreen()
                                  ),
                            );
                          });
                          return Dialog(
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              elevation: 0.0,
                              child: Center(
                                child: Container(
                                  width: getHorizontalSize(124),
                                  height: getVerticalSize(124),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: isDark
                                          ? ColorConstant.darkBg
                                          : ColorConstant.whiteA700),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: ColorConstant.blueA400,
                                    backgroundColor:
                                        ColorConstant.blueA400.withOpacity(.3),
                                  )),
                                ),
                              ));
                        },
                      );
                    },
                    variant: ButtonVariant.FillBlueA400,
                    fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
