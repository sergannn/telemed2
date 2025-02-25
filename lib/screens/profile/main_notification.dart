import 'dart:convert';
//import 'package:date_picker_timeline /date_picker_widget.dart';
import 'package:doctorq/date_picker_timeline-1.2.6/lib/date_picker_widget.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_tasks.dart';
import 'package:doctorq/screens/home/home_screen/widgets/autolayouthor_item_widget_zapisi.dart';
import 'package:doctorq/screens/home/home_screen/widgets/story_item_widget.dart';
import 'package:doctorq/screens/profile/main_notification_support.dart';
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

class MainNotificationsScreen extends StatelessWidget {
  const MainNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40), // фиксированный отступ
          // Верхняя панель с заголовком
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Уведомления',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Список уведомлений
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return NotificationItem(
                    isFirst: index == 0,
                    isSecond: index == 1,
                    isThree: index == 2,
                    isFourth: index == 3,
                    isFifth: index == 4,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final bool isFirst;
  final bool isSecond;
  final bool isThree;
  final bool isFourth;
  final bool isFifth;

  const NotificationItem({
    Key? key,
    required this.isFirst,
    required this.isSecond,
    required this.isThree,
    required this.isFourth,
    required this.isFifth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 247, 252),
        borderRadius: BorderRadius.circular(22),
      ),
      child: isFirst
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SupportNotification())
                    //HomeNotificationScreen()
                    //),
                    );
              },
              child: _buildSupportNotification())
          : isSecond
              ? _buildTwoNotification()
              : isThree
                  ? _buildThreeNotification()
                  : isFourth
                      ? _buildFourNotification()
                      : _buildFiveNotification(),
    );
  }

  Widget _buildSupportNotification() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40, // фиксированная ширина
          height: 40, // фиксированная высота
          alignment: Alignment.center,
          child: Icon(
            Icons.support_agent,
            size: 26,
            color: const Color.fromARGB(255, 142, 191, 231),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Поддержка',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Новое сообщение'),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 176, 214, 254),
              ),
              child: const Text('3',
                  style: TextStyle(color: Color.fromARGB(255, 16, 16, 16))),
            ),
            const SizedBox(height: 4),
            const Text('10:45', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildTwoNotification() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            Icons.message,
            size: 26,
            color: const Color.fromARGB(255, 142, 191, 231),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Запись к врачам',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Назначена новая запись'),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 176, 214, 254),
              ),
              child: const Text('2',
                  style: TextStyle(color: Color.fromARGB(255, 16, 16, 16))),
            ),
            const SizedBox(height: 4),
            const Text('09:30', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildThreeNotification() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            Icons.calendar_today,
            size: 26,
            color: const Color.fromARGB(255, 142, 191, 231),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Оплата', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Уведомнение об оплате'),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 249, 194, 196),
              ),
              child: const Text('1',
                  style: TextStyle(color: Color.fromARGB(255, 16, 16, 16))),
            ),
            const SizedBox(height: 4),
            const Text('08:15', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildFourNotification() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            Icons.settings,
            size: 26,
            color: const Color.fromARGB(255, 142, 191, 231),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Настройки',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Обновление доступно'),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 249, 194, 196),
              ),
              child: const Text('3',
                  style: TextStyle(color: Color.fromARGB(255, 16, 16, 16))),
            ),
            const SizedBox(height: 4),
            const Text('Вчера', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildFiveNotification() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            Icons.settings,
            size: 26,
            color: const Color.fromARGB(255, 142, 191, 231),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Баллы', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('У вас новый промокод'),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 249, 194, 196),
              ),
              child: const Text('1',
                  style: TextStyle(color: Color.fromARGB(255, 16, 16, 16))),
            ),
            const SizedBox(height: 4),
            const Text('Позже', style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
