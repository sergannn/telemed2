//import 'package:date_picker_timeline /date_picker_widget.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/profile/main_notification_support_tests.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SupportNotification extends StatelessWidget {
  TextEditingController autoLayoutVerController = TextEditingController();
  final ItemController itemController = Get.put(ItemController());

  SupportNotification({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),
        home: Scaffold(
            body: Column(children: [
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
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0),
                            borderRadius: BorderRadius.circular(28),
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
                                    'Суббота 18.02.2025',
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotificationsSupportTestsScreen()),
                                            );
//                                            NotificationsSupportTests
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
                                          '10:45',
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
                                      'Подняли цену на препарат , который вы часто заказываете',
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
                                        'В связи с тем, что данный препарат относится к санкционным лекарствам, бренд выпускающий данный препарат больше не может держать предыдущую цену. Но спешим вас обрадовать, что через наше приложение вы можете получить скидку в размере 20% на данный препарат',
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
                                            'Перейти к препаратам',
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
        ])));
  }
}
