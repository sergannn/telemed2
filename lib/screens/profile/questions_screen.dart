import 'dart:math' as math;

import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new FAQState();
}

class FAQState extends State<FAQScreen> {
  bool _isExpanded = false;
  bool _customTileExpanded = false;
  Widget whatFor(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.help,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Зачем мне это приложение?',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                softWrap: true,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 22,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget howTo(context) {
    return Column(children: <Widget>[
      ExpansionTile(
        onExpansionChanged: (bool expanded) {
          setState(() {
            _customTileExpanded = expanded;
            print(expanded);
          });
        },
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,

        trailing: Transform.rotate(
          angle: _customTileExpanded ? math.pi / 2 : 0,
          child: Icon(
            Icons.arrow_forward_ios,
            color: _customTileExpanded ? Colors.black : Colors.grey,
            size: 22,
          ),
        ),
        title: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(children: [
                IconButton(
                  icon: const Icon(
                    Icons.help,
                    color: Colors.black,
                    size: 20,
                  ),
                  onPressed: null, //() => Navigator.pop(context),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Как подготовиться к онлайн консультации?',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    softWrap: true,
                  ),
                ),
              ]),
            )),
        // subtitle: Text('Trailing expansion arrow icon'),
        children: <Widget>[ListTile(title: Text('This is tile number 1'))],
      )
    ]);
  }

  Widget whatWillIGet(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.help,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Что я получу в результате онлайн консультации?',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                softWrap: true,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 22,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(
              text: "Вопросы и предложения", context: context, height: 0),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16), //, vertical: 38),
                children: [
                  howTo(context),
                  whatFor(context),
                  whatWillIGet(context),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Медкарта',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Мой профиль',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Онлайн запись',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Запись на онлайн прием',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Оплата и баллы лояльности',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Пакеты услуг',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Я - пациент',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Подготовка к исследованиям',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Чат комьюнити',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              softWrap: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Остались вопросы ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'обратитесь к нам',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: getVerticalSize(100))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
