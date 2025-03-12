import 'dart:math' as math;

import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new FAQState();
}

class FAQState extends State<FAQScreen> {
  List<bool> _expansionStates = List<bool>.filled(12, false); // Состояния для каждой стрелки

  Widget _buildExpansionTile({
    required String title,
    required String content,
    required int index,
  }) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      onExpansionChanged: (bool expanded) {
        setState(() {
          _expansionStates[index] = expanded;
        });
      },
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      trailing: Transform.rotate(
        angle: _expansionStates[index] ? math.pi / 5 : 0,
        child: Icon(
          Icons.arrow_forward_ios,
          color: _expansionStates[index] ? Colors.black : Colors.grey,
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
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.help,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: null,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
      children: [
        ListTile(
          title: Text(content),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           SizedBox(height: 40),
          ...topBack(
            text: "Вопросы и предложения",
            context: context,
            height: 0,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildExpansionTile(
                    title: 'Как подготовиться к онлайн консультации?',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 0,
                  ),
                  _buildExpansionTile(
                    title: 'Зачем мне это приложение?',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 1,
                  ),
                  _buildExpansionTile(
                    title: 'Что я получу в результате онлайн консультации?',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 2,
                  ),
                  _buildExpansionTile(
                    title: 'Медкарта',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 3,
                  ),
                  _buildExpansionTile(
                    title: 'Мой профиль',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 4,
                  ),
                  _buildExpansionTile(
                    title: 'Онлайн-запись',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 5,
                  ),
                  _buildExpansionTile(
                    title: 'Запись на онлайн-прием',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 6,
                  ),
                  _buildExpansionTile(
                    title: 'Оплата и баллы лояльности',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 7,
                  ),
                  _buildExpansionTile(
                    title: 'Пакеты услуг',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 8,
                  ),
                  _buildExpansionTile(
                    title: 'Я - пациент',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 9,
                  ),
                  _buildExpansionTile(
                    title: 'Подготовка к исследованиям',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 10,
                  ),
                  _buildExpansionTile(
                    title: 'Чат-комьюнити',
                    content: 'Если вы хотите что-то уточнить у данного врача, воспользуйтесь повторной онлайн консультацией в формате чата или запишитесь на другой формат консультации.',
                    index: 11,
                  ),
                   Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                text: 'Напишите нам',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Логика для клика
                    print('Нажали на "Напишите нам"');
                  },
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
          //отступ снизу
                        Container(height: getVerticalSize(100))
        ],
      ),
    );
  }
}
