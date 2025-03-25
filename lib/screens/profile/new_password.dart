import 'dart:async';

import 'package:doctorq/screens/auth/forgot/password_otp_active_screen/dial.dart';
import 'package:doctorq/screens/profile/akk_information.dart';
import 'package:doctorq/screens/profile/blank_screen/blank_screen.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/theme/color_constant.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  final bool isRepeatPassword;
  const NewPasswordScreen({Key? key, this.isRepeatPassword = false})
      : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  int selectedIndex = 0;
  String? newPassword;
  String? repeatedPassword;

  // В _NewPasswordScreenState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(
              text: widget.isRepeatPassword
                  ? "Повторите пароль"
                  : "Изменить пароль для входа",
              context: context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                children: [
                  Container(
                    width: size.width,
                    margin: getMargin(top: 6, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Индикаторы ввода
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 12,
                              height: 12,
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorConstant.fromHex("81AEEA"),
                                  width: 2,
                                ),
                                color: index < selectedIndex
                                    ? ColorConstant.fromHex("81AEEA")
                                    : Colors.transparent,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index < selectedIndex
                                      ? ColorConstant.fromHex("81AEEA")
                                      : Colors.transparent,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 46),
                        Center(
                          child: Text(
                            widget.isRepeatPassword
                                ? "Повторите пароль"
                                : "Придумайте новый пароль",
                            style: TextStyle(
                              color: selectedIndex >= 4
                                  ? ColorConstant.fromHex("81AEEA")
                                  : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 46),
                        DialPad(
                          buttonColor: ColorConstant.fromHex("EDF5FF"),
                          hideSubtitle: true,
                          hideDialButton: true,
                          enableDtmf: true,
                          backspaceButtonIconColor:
                              ColorConstant.fromHex("81AEEA"),
                          buttonTextColor: Colors.black,
                          dialOutputTextColor: Colors.black,
                          keyPressed: (value) {
                            setState(() {
                              print("hello");
                              selectedIndex++;
                              if (widget.isRepeatPassword) {
                                repeatedPassword = repeatedPassword != null
                                    ? repeatedPassword! + value
                                    : value;
                              } else {
                                newPassword = newPassword != null
                                    ? newPassword! + value
                                    : value;
                              }
                            });
                          },
                          makeCall: (number) async {
                            print("making call");
                            print(number);
                            if (number.toString().length >= 4) {
                              if (widget.isRepeatPassword) {
                                if (repeatedPassword == newPassword) {
                                  print("...");

                                  showDialog(
                                      context: context,
                                      builder: (dcontext) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: Center(
                                              child: Container(
                                                width: getHorizontalSize(324),
                                                height: getVerticalSize(224),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      ColorConstant.whiteA700,
                                                ),
                                                child: Column(children: [
                                                  Center(
                                                    child: Image.asset(
                                                      'assets/images/Vector.png',
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  //child= это кнопка
                                                  TextButton(
                                                      child: Text("ok"),
                                                      onPressed: () {
                                                        Navigator.pop(dcontext);
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AkkInfoScreen(),
                                                          ),
                                                        );
                                                      })
                                                ]),
                                              ),
                                            ),
                                          ));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text('Пароли не совпадают'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Попробовать снова'),
                                        ),
                                      ],
                                    ),
                                  );
                                  setState(() {
                                    selectedIndex = 0;
                                    repeatedPassword = null;
                                  });
                                }
                              } else {
                                //появляется поверх
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewPasswordScreen(
                                      isRepeatPassword: true,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
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
    );
  }
}
