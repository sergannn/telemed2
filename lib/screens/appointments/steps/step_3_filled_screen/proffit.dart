import 'dart:ui';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/book_screen/book_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
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
    this.isDark = false, // Добавили дефолтное значение
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

// ignore: must_be_immutable
class ProffitScreen extends StatefulWidget {
  ContactMethods contactMethod;
  DateTime date;
  String time;
  ProffitScreen({
    Key? key,
    required this.contactMethod,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  _AppointmentsStep3FilledScreenState createState() =>
      _AppointmentsStep3FilledScreenState();
}

class _AppointmentsStep3FilledScreenState extends State<ProffitScreen> {
  @override
  Widget build(BuildContext context) {
    print(context.selectedDoctor);
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
                            color: const Color.fromARGB(255, 247, 247, 247)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Добавляем кружок с галочкой слева от текста
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
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
                                  const SizedBox(width: 8),
                                  Text(
                                    'Вы успешно записаны на прием',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 26),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
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
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 203, 228, 255),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
// Левая колонка
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    size: 16,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'День',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 16, 16, 16),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),

// Правая колонка
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: const Text(
                                                  '26.01.25',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 203, 228, 255),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
// Левая колонка
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.lock_clock,
                                                    size: 16,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'Время',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 16, 16, 16),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),

// Правая колонка
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: const Text(
                                                  '14:00',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Заголовок
                                Text(
                                  'Время/дата',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),

                                // Описание
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    'Вставить отображение выбранных даты/времени для записи',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 12),
                                // Кнопка и время
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            CustomButton(
              isDark: isDark,
              width: size.width,
              text: "Отменить запись",
              margin: getMargin(
                left: 24,
                top: 22,
                right: 24,
              ),
              variant: ButtonVariant.FillBlueA400,
              fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
              alignment: Alignment.center,
              onPressed: () {
                showCancelDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showCancelDialog(BuildContext context) {
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
                Text(
                  'Вы точно хотите отменить запись?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomButton(
                  width: double.infinity,
                  text: "Отменить запись",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () async {
                    await showLoadingDialog(context);
                    Navigator.pop(context);
                    showRescheduleDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showLoadingDialog(BuildContext context) async {
  // Показать диалог загрузки
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
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 125, 171, 223),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Отмена записи...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // Задержка, чтобы показать индикатор загрузки
  await Future.delayed(Duration(seconds: 2));

  // Закрываем диалог загрузки
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
    // После закрытия диалога загрузки открываем следующее окно
    //showRescheduleDialog(context);
  }
}

void showRescheduleDialog(BuildContext context) {
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
                Text(
                  'Хотите перезаписаться к данному врачу?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomButton(
                  width: double.infinity,
                  text: "Перезаписаться",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentsBookScreen()));
                    // Здесь добавьте логику перезаписи
                  },
                ),
                SizedBox(height: 12),
                CustomButton(
                  width: double.infinity,
                  text: "Перейти на главную",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    // Здесь добавьте логику перехода на главную страницу
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
