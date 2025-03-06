import 'dart:convert';
//import 'package:date_picker_timeline /date_picker_widget.dart';
import 'package:doctorq/date_picker_timeline-1.2.6/lib/date_picker_widget.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_tasks.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_zapisi.dart';
import 'package:doctorq/screens/home/home_screen/widgets/story_item_widget.dart';
import 'package:doctorq/screens/profile/settings/appearance_screen/appearance_screen.dart';
import 'package:doctorq/screens/profile/widgets/autolayouthor_item_widget_profile_tasks.dart';
import 'package:doctorq/screens/stories/story_scren.dart';
import 'package:doctorq/services/auth_service.dart';
import "package:story_view/story_view.dart";
import 'package:animate_do/animate_do.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/home/favorite_doctor_screen/favorite_doctor_screen.dart';
import 'package:doctorq/screens/home/notification_screen/notification_screen.dart';
import 'package:doctorq/screens/home/search_doctor_screen/search_doctor_screen.dart';
import 'package:doctorq/screens/home/specialist_doctor_screen/specialist_doctor_screen.dart';
import 'package:doctorq/screens/home/top_doctor_screen/choose_specs_screen_step_1.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/spacing.dart';
//import 'widgets/autolayouthor1_item_widget.dart';
//import 'widgets/autolayouthor_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:doctorq/data_files/specialist_list.dart';
import 'package:story_view/story_view.dart';
//import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
//final GlobalKey<RandomTextRevealState> globalKey = GlobalKey();

class ExiteSureScreen extends StatelessWidget {
  const ExiteSureScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<State> _dialogKey = GlobalKey();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40), // фиксированный отступ

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [     
                              // Row для даты и иконки
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 96, 159, 222),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.back_hand_outlined,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Заголовок
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06),
                                        child: Text(
                                          'Вы точно хотите выйти?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.055,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 12),
                                      // Кнопка и время
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Кнопка отмены
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: OutlinedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                side: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              child: Text(
                                                'Отмена',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.045,
                                                ),
                                              ),
                                            ),
                                          ),
// Кнопка выхода
SizedBox(
  width: MediaQuery.of(context).size.width * 0.35,
  child: ElevatedButton(
   
// В кнопке
onPressed: () async {
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
                    color: true
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
    var logOutRes =  await logOut();
    if (logOutRes == true) {
      gogo(false, context);
    }
  
   
  
},
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 96, 159, 222),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    child: Text(
      'Выйти',
      style: TextStyle(
        color: Colors.white,
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    ),
  ),
),
                                        ],
                                      ),
                                    ]),
                              )
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
    );
  }

  gogo(isDark,context) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(milliseconds: 600), () {
          Navigator.of(context).pop(true);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignInBlankScreen() //user: user
//                                          uId: id,
                  ),
              (Route<dynamic> route) => false);
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
}
