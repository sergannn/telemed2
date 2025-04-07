import 'dart:math';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/daily/main.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreenDoctor.dart';
import 'package:doctorq/screens/auth/forgot/password_otp_active_screen/password_otp_active_screen.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/screens/auth/forgot/password_method_screen/password_method_screen.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/theme/svg_constant.dart';
import 'package:doctorq/utils/pub.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_checkbox.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/boxshadow.dart';
import '../../../widgets/spacing.dart';
import '../sign_up_blank_screen/sign_up_blank_screen.dart';
import 'doctor_screen.dart';
//import 'package:flutter_login_yandex_updated/flutter_login_yandex.dart';
//import 'package:flutter_login_yandex/flutter_login_yandex.dart';

class SignInBlankScreen extends StatefulWidget {
  SignInBlankScreen({Key? key}) : super(key: key);
//  final startupPageKey = GlobalKey<StartupPageState>();

//  final GlobalKey<FlipWidgetState> _flipKey = GlobalKey(); // Add this line
  @override
  State<SignInBlankScreen> createState() => _SignInBlankScreenState();
}

class _SignInBlankScreenState extends State<SignInBlankScreen> {
  bool checkbox = false;
  bool obscure = true;
  String _token = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _isFormValid = ValueNotifier(false);
  final _flipKey = GlobalKey<_FlipWidgetState>();
  gogo(isDark) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.of(context).pop(true);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Main() //user: user
//                                          uId: id,
                  ));
          // (Route<dynamic> route) => false);
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
                  backgroundColor: ColorConstant.blueA400.withOpacity(.3),
                )),
              ),
            ));
      },
    );
  }

  forceLog(isDark) async {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(milliseconds: 600), () {});
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
                  backgroundColor: ColorConstant.blueA400.withOpacity(.3),
                )),
              ),
            ));
      },
    );
    var authRes = await authUser(context, "s@s.ru", "123456");
    if (authRes == true) {
      gogo(false);
    }
  }

  void inspectTheme(BuildContext context) {
    final theme = Theme.of(context);
    print('\n=== Theme Inspection ===');
    print('Background: ${theme.colorScheme.background}');
    print('Primary: ${theme.colorScheme.primary}');
    print('On Primary: ${theme.colorScheme.onPrimary}');
    print('Typography: ${theme.textTheme}');
    print('=====================\n');
  }

  @override
  Widget build(BuildContext context) {
    inspectTheme(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = Theme.of(context).scaffoldBackgroundColor;
    print("default scaf color");
    print(color);
    return Scaffold(
        resizeToAvoidBottomInset: true,
//        backgroundColor: Colors.white,
        // floatingActionButton:
        //   FloatingActionButton(onPressed: null, child: Text("a")),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          //mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: getPadding(
                    left: 16,
                    top: 30,
                    right: 24,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.asset(
                      ImageConstant.appLogoAnn,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(
                  left: 16,
                  top: 30,
                  right: 24,
                ),
                child: Text(
                  "Войти",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: getFontSize(
                      23,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                margin: getMargin(
                  left: 24,
                  top: 30,
                  right: 24,
                ),
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 5,
                                right: 24,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: getPadding(),
                                    child: Text(
                                      "Логин",
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
                            Container(
                              /*
                              decoration: BoxDecoration(
                                  boxShadow: isDark
                                      ? customDarkBoxShadow
                                      : customBoxShadow),*/
                              child: CustomTextFormField(
                                controller: emailController,
                                isDark: isDark,
                                width: size.width,
                                focusNode: FocusNode(),
                                hintText: "example@mail.ru",
                                margin: getMargin(
                                  top: 11,
                                ),
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
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                margin: getMargin(
                  left: 24,
                  top: 20,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: getPadding(
                                left: 5,
                                top: 1,
                                right: 24,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 3,
                                    ),
                                    child: Text(
                                      "Пароль",
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
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: isDark
                                      ? customDarkBoxShadow
                                      : customBoxShadow),
                              child: CustomTextFormField(
                                controller: passwordController,
                                isDark: isDark,
                                width: size.width,
                                focusNode: FocusNode(),
                                hintText: "Password",
                                margin: getMargin(
                                  top: 11,
                                ),
                                textInputAction: TextInputAction.done,
                                alignment: Alignment.center,
                                suffix: Container(
                                  margin: getMargin(
                                    left: 24,
                                    right: 24,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        print("chaning obscure");
                                        obscure = !obscure;
                                      });
                                    },
                                    child: CommonImageView(
                                      imagePath: obscure
                                          ? ImageConstant.visibilityOff
                                          : ImageConstant.visibilityOn,
                                    ),
                                  ),
                                ),
                                suffixConstraints: BoxConstraints(
                                  maxWidth: getHorizontalSize(
                                    74.00,
                                  ),
                                  maxHeight: getVerticalSize(
                                    24.00,
                                  ),
                                ),
                                isObscureText: obscure,
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
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  CustomCheckbox(
                    alignment: Alignment.centerLeft,
                    text: "Запомнить меня",
                    iconSize: 16,
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
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: getPadding(
                        left: 24,
                        top: 20,
                        right: 24,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordMethodScreen()
                                //const ForgotPasswordOtpActiveScreen()
                                ),
                          );
                        },
                        child: Text(
                          "Забыли пароль?",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
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
                    ),
                  )
                ])),
            ValueListenableBuilder<bool>(
                valueListenable: _isFormValid,
                builder: (context, isValid, child) {
                  return CustomButton(
                      onDoubleTap: () async {
                        await forceLog(isDark);
                      },
                      isDark: isDark,
                      width: size.width,
                      text: "Войти в систему",
                      margin: getMargin(
                        left: 24,
                        top: 22,
                        right: 24,
                      ),
                      variant: ButtonVariant.FillBlueA400,
                      fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                      alignment: Alignment.center,
                      onTap: () async {
                        print("tap");
                        /*if (forceUserLogin) {
                      emailController.text = testUserLogin;
                      passwordController.text = testUserPassword;
                    }
                        var authRes = await authUser(context,
                            emailController.text, passwordController.text);
                        if (authRes == true) {
                          gogo(isDark);
                        }
                        */
                      });
                }),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 15,
                  right: 24,
                ),
                child: Text(
                  "или",
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
                    top: 10,
                    right: 24,
                  ),
                  child: FloatingActionButton.extended(
                    elevation: 0, // Removes the default shadow
                    // highlightElevation: 1, // Removes the shadow when pressed
                    // label:'',
                    backgroundColor: ColorConstant.fromHex('F0F7FE'),
                    onPressed: () async {
                      _flipKey.currentState
                          ?.startOnceAnimation(); // Use _flipKey here
                      // currentState?.startAnimation();
                      //return null;
                      //      final flutterLoginYandexPlugin = FlutterLoginYandex();
                      //      final response = await flutterLoginYandexPlugin.signIn();
                    },
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        //  color: Colors.white,
                      ),
                      // padding: EdgeInsets.all(12.0),
                      child: Row(children: [
                        // Figma Flutter Generator ButtonwithcenterediconWidget - FRAME - VERTICAL
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              color: Color.fromRGBO(240, 246, 253, 1),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 41.25, vertical: 16.5),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: FlipWidget(key: _flipKey),
                                    width: 41.341552734375,
                                    height: 16.22828483581543,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                  ),
                                ])),

                        //    FlipWidget(key: _flipKey)
                        //    FlipWidget(),
                        // SvgPicture.string(SvgConstant.Ndex_svg,
                        //      color: Colors.red),
                        //  SvgPicture.string(SvgConstant.Y_svg)
                      ]),
                    ),

                    ///assets/images/logos--yandex-ru.png
                  )),
              /* HorizontalSpace(width: 16),
                        Expanded(
                          child: CustomButton(
                            onTap: () async {
                              final response =
                                  await _flutterLoginYandexPlugin.signOut();
                              print(response);
                              setState(() {
                                _token = '';
                              });
                            },
                            isDark: isDark,
                            width: 178,
                            text: "Клиент",
                            variant: ButtonVariant.OutlineGray100,
                            shape: ButtonShape.RoundedBorder12,
                            fontStyle: ButtonFontStyle.SourceSansProSemiBold16,
                            prefixWidget: Container(
                              margin: getMargin(
                                right: isRtl ? 0 : 12,
                                left: isRtl ? 12 : 0,
                              ),
                              child: CommonImageView(
                                svgPath: ImageConstant.imgGoogle,
                              ),
                            ),
                          ),
                        ),*/
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: getPadding(
                  left: 24,
                  top: 15,
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
                        "Нет аккаунта?",
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
/*    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>*/

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpBlankScreen()),
                        );
                      },
                      child: Text(
                        "Регистрация",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.fromHex("638ABD"), //.blueA400,
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
            ),
            Center(
                child: Text("Политика конфиденциальности",
                    style: TextStyle(color: ColorConstant.fromHex("638ABD"))))
          ],
        ))));
  }
}

class FlipWidget extends StatefulWidget {
  const FlipWidget({super.key}); // Add this line
  static Type get stateType => _FlipWidgetState;
  @override
  _FlipWidgetState createState() => _FlipWidgetState();
}

class _FlipWidgetState extends State<FlipWidget> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..forward();
  }

  void startOnceAnimation() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  void startAnimation() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.repeat();
    }
  }

  void resetAndStartAnimation() {
    if (_controller.isCompleted) {
      _controller.reset();
    }
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.isCompleted ? _controller.reverse() : _controller.forward();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final double value = _controller.value;
          final Matrix4 matrix = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Add perspective
            ..rotateY(value * pi * 2);

          return Transform(
            transform: matrix,
            alignment: FractionalOffset.center,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstant.fromHex('F0F7FE'),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(children: [
                Transform.translate(
                  offset: Offset(0, -3), // Adjust -8 to move up more or less
                  child: SvgPicture.string(
                    SvgConstant.Ndex_svg,
                    //  color: Colors.red,
                  ),
                ),
                //   SvgPicture.string(SvgConstant.Ndex_svg, color: Colors.red),
                SvgPicture.string(
                  SvgConstant.Y_svg,
                )
              ]),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
