import 'dart:ui';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/book_screen/book_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/widgets/top_back.dart';
import '../../../../widgets/spacing.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDark; // Убрали required
  final double width;
  final String text;
  final EdgeInsetsGeometry? margin;
  final ButtonVariant variant;
  final ButtonFontStyle fontStyle;
  final Alignment alignment;

  const CustomButton({
    Key? key,
    this.onPressed,
    this.isDark = false, 
    required this.width,
    required this.text,
    this.margin,
    required this.variant,
    required this.fontStyle,
    required this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isDark
              ? const Color.fromARGB(255, 125, 171, 223)
              : const Color.fromARGB(255, 125, 171, 223),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class OnlineReceptionAudioComplete extends StatefulWidget {
  final ContactMethods? contactMethod;
  final DateTime? date;
  final String? time;

  const OnlineReceptionAudioComplete({
    Key? key,
    this.contactMethod,
    this.date,
    this.time,
  }) : super(key: key);

  @override
  _AppointmentsStep3FilledScreenState createState() =>
      _AppointmentsStep3FilledScreenState();
}

class _AppointmentsStep3FilledScreenState extends State<OnlineReceptionAudioComplete> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ...topBack(
                text: "",
                context: context,
                height: 0.0,
                icon: Icon(
                  Icons.circle,
                  color: Colors.transparent,
                  size: 24,
                )),
            VerticalSpace(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: getPadding(
                            left: 24,
                            top: 14,
                            right: 24,
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 251, 251, 251)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Изображение вместо текста
                                Center(
                                  child: Image.asset(
                                    'assets/images/Vector.png', // Замените на путь к вашему изображению
                                    width:
                                        150, // Настройте размер под ваши нужды
                                    height: 150,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          ),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 4,
                          right: 24,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Добавляем кружок с галочкой слева от текста
                              Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
                                children: [ 
                                  Text(
                                    'Аудио с врачом успешно завершено',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
const SizedBox(width: 8),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 176, 214, 254),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 14,
                                      color:
                                          const Color.fromARGB(255, 16, 16, 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 26),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/images/11.png'),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Парфенов К.С.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const Text('Акушер-гинеколог'),
                                        const Text(
'О враче    Был в сети 1 мин назад',
style: TextStyle(
fontSize: 10,
color: Color.fromARGB(255, 91, 91, 91),
),
),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(height: 14),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Заменяем изображение на два контейнера с информацией
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Центрирование по горизонтали
    crossAxisAlignment: CrossAxisAlignment.center, // Центрирование по вертикали
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(0xF8, 0xF8, 0xF8, 1.0),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
// Левая колонка
                                           
                                            const SizedBox(width: 8),

// Правая колонка
                                           Expanded(
  flex: 3,
  child: Container(
    child: const Center(
      child: Text(
        '45:00 минут',
        style: TextStyle(
           fontWeight: FontWeight.w600,  
          color: Color.fromARGB(255, 129, 174, 234),
          fontSize: 14,
        ),
      ),
    ),
  ),
),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
  style: ElevatedButton.styleFrom(
    fixedSize: const Size(double.infinity, 50), // Фиксированная высота 50
    shape: RoundedRectangleBorder(           // Скругленные углы радиусом 24
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Colors.white,           // Белый фон
    side: BorderSide(                         // Обводка цвета 81AEEA
      color: Color.fromARGB(255, 129, 174, 234),
      width: 0.8,
    ),
  ),
  onPressed: () {}, // Здесь будет ваш обработчик нажатия
  child: const Text(
    'Архив записей',
    textAlign: TextAlign.center,             // Текст по центру
    style: TextStyle(
        fontWeight: FontWeight.w500,
      color: Color.fromARGB(255, 16, 16, 16), // Темный текст
      fontSize: 14,                           // Размер шрифта
    ),
  ),
),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),


            
          Column(
  children: [
    CustomButton(
      isDark: isDark,
      width: size.width - 48, // Вычитаем отступы слева и справа
      text: "Оставить отзыв",
      margin: EdgeInsets.zero, // Убираем margin
      variant: ButtonVariant.FillBlueA400,
      fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
      alignment: Alignment.center,
      onPressed: () => _showReviewDialog(context),
    ),
    SizedBox(height: 6),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
          color: Color.fromARGB(255, 129, 174, 234),
          width: 0.8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
        fixedSize: Size(size.width - 48, 50), // Одинаковая ширина
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      child: Text(
        "Перейти на главную",
        style: TextStyle(
          color: Color.fromARGB(255, 129, 174, 234),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ),
  ],
),
                  ],
                ),
              ),
            );
          
  }

  void _showReviewDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Стрелка для свайпа вниз
              Container(
                height: 4,
                width: 40,
                margin: EdgeInsets.only(top: 8, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Звездочки
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (_) => Icon(Icons.star, color: Colors.yellow[700], size: 28)),
              ),
              
              // Текст вопроса
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 14),
                child: Text(
                  'Как прошел ваш онлайн прием с врачом?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              
              // Подсказка о количестве символов
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'не более 250 символов',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
              
              // Контейнер с отзывом
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 248, 255, 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Мне понравился врач . Сразу запросил доступ к моей медкарте и на этом мы сэкономили время, учитывая, что сама консультация стоит недешево. Диагноз поставил предварительный . В целом, буду теперь консультироваться у него периодически в целях профилактики.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              
              // Секция для файлов
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(228, 240, 255, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.add, color: Colors.blue),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Добавить файл',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Expanded(child: Container()), // Пространство для будущих файлов
                  ],
                ),
              ),
              
              // Кнопка отправки отзыва
              Padding(
                padding: EdgeInsets.all(24),
                child: CustomButton(
                 
                  width: double.infinity,
                  text: "Оставить отзыв",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.pop(context);
                    _showReviewSuccessDialog(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReviewSuccessDialog(BuildContext context) {
     logOut();
  print("logged out");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/Vector.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Отзыв успешно оставлен',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}