import 'dart:convert';
//import 'package:date_picker_timeline /date_picker_widget.dart';
import 'package:doctorq/date_picker_timeline-1.2.6/lib/date_picker_widget.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_tasks.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_zapisi.dart';
import 'package:doctorq/screens/home/home_screen/widgets/story_item_widget.dart';
import 'package:doctorq/screens/profile/settings/appearance_screen/appearance_screen.dart';
import 'package:doctorq/screens/profile/widgets/autolayouthor_item_widget_profile_tasks.dart';
import 'package:doctorq/screens/stories/story_scren.dart';
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

class NotificationsSupportTestsScreen extends StatelessWidget {
  const NotificationsSupportTestsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40), // фиксированный отступ
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Поддержка', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Пятница 12.01.2025',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 157, 157, 157),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: const Color.fromARGB(
                                            255, 126, 179, 239),
                                        size: 24),
                                    onPressed: () {
                                      // Здесь будет код для удаления
                                    },
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 238, 238, 238)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Заголовок
                                    Text(
                                      'Пройдите наш тест на важные показатели для здоровья',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 17, 17, 17),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),

                                    // Описание
                                    Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Text(
                                        'Наш тест на важные показатели здоровья покажет вам , на что обратить свое внимание и носит рекомендательный характер. Пройдите по ссылке, чтобы ознакомиться и уже сейчас сделать свой организм выносливее и крепче',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 17, 17, 17),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 12),
                                    // Кнопка и время
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Кнопка
                                        ElevatedButton(
                                          onPressed: () {
                                            // Здесь будет код для перехода к препаратам
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 96, 159, 222),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                          ),
                                          child: Text(
                                            'Перейти к трекеру тестов',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),

                                        // Время
                                        Text(
                                          '19:45',
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 157, 157, 157),
                                            fontFamily: 'Source Sans Pro',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
