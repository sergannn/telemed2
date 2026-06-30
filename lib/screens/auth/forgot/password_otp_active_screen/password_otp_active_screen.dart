import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:doctorq/services/auth_service.dart';

class ForgotPasswordOtpActiveScreen extends StatelessWidget {
  final dynamic response;
  final dynamic password;
  ForgotPasswordOtpActiveScreen({Key? key, this.response, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final email = response['email']?.toString() ?? '';
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
                      "Код подтверждения был отправлен push-уведомлением.\nВведите его, чтобы завершить регистрацию.",
                      textAlign: TextAlign.center,
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
                        onChanged: (value) async {
                          if (value.length == 4) {
                            final isValid = await verifyRegistrationPushCode(
                              email,
                              value,
                            );
                            if (isValid) {
                              var authRes = await authUser(
                                context,
                                email,
                                password,
                              );
                              if (authRes == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Main()),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Неверный код подтверждения'),
                                  ),
                                );
                              }
                            }
                          }
                        },
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
