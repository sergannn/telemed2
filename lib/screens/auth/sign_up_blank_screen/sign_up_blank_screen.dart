import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/auth/forgot/password_otp_active_screen/password_otp_active_screen.dart';
import 'package:doctorq/screens/profile/blank_screen/blank_screen.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/doctor_screen.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_checkbox.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:doctorq/services/auth_service.dart';

import 'fields.dart';

class SignUpBlankScreen extends StatefulWidget {
  SignUpBlankScreen({Key? key}) : super(key: key);

  @override
  State<SignUpBlankScreen> createState() => _SignUpBlankScreenState();
}

class _SignUpBlankScreenState extends State<SignUpBlankScreen> {
  bool checkbox = false;
  bool obscure = true;
  bool _showValidationErrors = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
//    bool isRtl = context.locale == Constants.arLocal;
//    return Text("a");
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
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
                ...RegFields.getAll().entries.map((entry) {
                  final field = entry.value;
                  print(field['label']);

                  if (entry.key == "email") {
                    emailController = field['controller'];
                  }
                  if (entry.key == 'phone') {
                    phoneController = field['controller'];
                  }
                  if (entry.key == "password") {
                    passwordController = field['controller'];
                  }
                  return Align(
                      alignment: Alignment.centerLeft,
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: double.infinity,
                              margin: getMargin(
                                left: 24,
                                top: 30,
                                right: 24,
                              ),
                              decoration: BoxDecoration(),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: getPadding(
                                                    left: 24,
                                                    right: 24,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding: getPadding(),
                                                        child: Text(
                                                          field['label'],
                                                          style: TextStyle(
                                                            color: isDark
                                                                ? Colors.white
                                                                : ColorConstant
                                                                    .bluegray800A2,
                                                            fontSize:
                                                                getFontSize(16),
                                                            fontFamily:
                                                                'Source Sans Pro',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      if (field['*'] != null)
                                                        Padding(
                                                          padding: getPadding(
                                                              bottom: 5),
                                                          child: Text(
                                                            "*",
                                                            style: TextStyle(
                                                              color:
                                                                  ColorConstant
                                                                      .redA700A2,
                                                              fontSize:
                                                                  getFontSize(
                                                                      14),
                                                              fontFamily:
                                                                  'Source Sans Pro',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  )),
                                              Container(
                                                child: CustomTextFormField(
                                                  controller:
                                                      field['controller'],
                                                  isDark: _showValidationErrors &&
                                                          field['validator'] !=
                                                              null &&
                                                          field['validator'](
                                                                  field['controller']
                                                                      .text) !=
                                                              null
                                                      ? true
                                                      : false,
                                                  width: size.width,
                                                  hintText: field['hint'],
                                                  margin: getMargin(top: 11),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  isObscureText:
                                                      field['obscure'],
                                                  validator: field['validator'],
                                                ),
                                              ),
                                              //Positioned(child: Text("ab"))
                                            ],
                                          ),
                                        ))
                                  ]))));
                }).toList(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomCheckbox(
                    fontStyle: CheckboxFontStyle.ser, //SourceSansProSemiBold14,
                    alignment: Alignment.centerLeft,
                    text: "Согласен на обработку персональных данных",
                    iconSize: 10,
                    value: checkbox,
                    padding: getPadding(
                      left: 48,
                      top: 22,
                      right: 48,
                    ),
                    onChange: (value) {
                      checkbox = value;
                      setState(() {});
                    },
                  ),
                ),
                CustomButton(
                  isDark: isDark,
                  width: size.width,
                  text: "Продолжить",
                  margin: getMargin(
                    left: 24,
                    top: 22,
                    right: 24,
                  ),
                  onTap: () async {
                    setState(() {
                      _showValidationErrors = true;
                    });

                    if (!validateForm()) {
                      print("problem");

                      return null;
                    }
                      var regRes = await regUser(context, emailController.text,
                        '123456',"patient");
                        //passwordController.text, "patient"); //_selectedRole ?? 
                    if (regRes) {
                      //authRes == true) {
                      print("ok");
                      var code = generateRandomCode();
                    //  var smsRes = await sendSMS(phoneController.text, code);
                      var emailRes =
                          await sendEmail(emailController.text, code);
                      //print(smsRes?['code']);
                      print(emailRes?['code']);
                      showDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(milliseconds: 600), () {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).push(//AndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordOtpActiveScreen(
                                            response: emailRes)
                                    //const ProfileBlankScreen()
                                    ));
                            //(Route<dynamic> route) => false);
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
                    }
                  },
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                ),
                /*Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      top: 24,
                      right: 24,
                    ),
                    child: Text(
                      "or continue with",
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
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      top: 27,
                      right: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: CustomButton(
                            isDark: isDark,
                            width: 178,
                            text: "Facebook",
                            variant: ButtonVariant.OutlineGray100,
                            shape: ButtonShape.RoundedBorder12,
                            fontStyle: ButtonFontStyle.SourceSansProSemiBold16,
                            prefixWidget: Container(
                              padding: getPadding(
                                left: 8,
                                top: 3,
                                right: 8,
                                bottom: 3,
                              ),
                              margin: getMargin(
                                  right: isRtl ? 0 : 12, left: isRtl ? 12 : 0),
                              decoration: BoxDecoration(
                                color: ColorConstant.indigo600,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    12.50,
                                  ),
                                ),
                              ),
                              child: CommonImageView(
                                svgPath: ImageConstant.imgFacebook,
                              ),
                            ),
                          ),
                        ),
                        HorizontalSpace(width: 16),
                        Expanded(
                          child: CustomButton(
                            isDark: isDark,
                            width: 178,
                            text: "Google",
                            variant: ButtonVariant.OutlineGray100,
                            shape: ButtonShape.RoundedBorder12,
                            fontStyle: ButtonFontStyle.SourceSansProSemiBold16,
                            prefixWidget: Container(
                              margin: getMargin(
                                  right: isRtl ? 0 : 12, left: isRtl ? 12 : 0),
                              child: CommonImageView(
                                svgPath: ImageConstant.imgGoogle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      top: 37,
                      right: 24,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: getPadding(
                            bottom: 1,
                          ),
                          child: Text(
                            "Already have an account?",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.bluegray400,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        HorizontalSpace(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInBlankScreen()),
                            );
                          },
                          child: Text(
                            "Sign in",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.blueA400,
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    bool isValid = true;
    print('validating');
    var last_error = '';
    for (final entry in RegFields.getAll().entries) {
      final field = entry.value;
      final controller = field['controller'] as TextEditingController;
      final validator = field['validator'];

      if (validator != null) {
        final error = validator(controller.text);
        if (error != null) {
          isValid = false;
          last_error = error;
        }
      }
    }
    // Показываем ошибку пользователю
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(last_error)),
      );
    }
    return isValid;
  }
}
