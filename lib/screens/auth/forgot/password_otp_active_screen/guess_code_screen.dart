import 'package:doctorq/app_export.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dial.dart';
import 'package:doctorq/screens/profile/blank_screen/blank_screen.dart';

class GuessCodeScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<GuessCodeScreen> {
  int selectedIndex = 0; // Отслеживаем выбранную точку

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              
              Container(
                width: size.width,
                margin: getMargin(top: 36, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Владимир Иванов",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getFontSize(26),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 46), // Отступ между текстом и точками
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Центрирование по горизонтали
                      mainAxisSize: MainAxisSize.min, // Минимальная ширина
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(4, (index) {
                        print(selectedIndex);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            width: 12,
                            height: 12,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index < selectedIndex
                                  ? ColorConstant.fromHex("81AEEA")
                                  : ColorConstant.fromHex("EEEEEE"),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 46),
              Center(child: Text("Придумайте код из четырех цифр ")),
              SizedBox(height: 46), // Отступ межд
              DialPad(
                  buttonColor: ColorConstant.fromHex("EDF5FF"),
                  hideSubtitle: true,
                  hideDialButton: false,
                  enableDtmf: true,
                  backspaceButtonIconColor: ColorConstant.fromHex("81AEEA"),
                  buttonTextColor: Colors.black,
                  dialOutputTextColor: Colors.black,
                  keyPressed: (value) {
                    print(value);
                    return;
                    //widget.makeCall();

                    if (selectedIndex < 4) {
                      setState(() {
                        selectedIndex++;
                        print(selectedIndex);
                        print('$value was pressed');
                      });
                    }
                  },
                  makeCall: (number) async {
                    //  number = '';
                    print(number);
                    if (number.toString().length > 4) {
                      print("dada");
                      var authRes =
                          await authUser(context, "john@example.com", "123456");
                      if (authRes == true) {
                        showDialog(
                          barrierColor: Colors.black.withOpacity(0.5),
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 600),
                                () {
                              Navigator.of(context).pop(true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileBlankScreen()
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
                                        color: false
                                            ? ColorConstant.darkBg
                                            : ColorConstant.whiteA700),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: ColorConstant.blueA400,
                                      backgroundColor: ColorConstant.blueA400
                                          .withOpacity(.3),
                                    )),
                                  ),
                                ));
                          },
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
