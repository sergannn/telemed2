import 'dart:ui';

import 'package:doctorq/screens/appointments/book_screen/book_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_3_filled_screen/proffit.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/profile/new_password.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/top_back.dart';
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

class AkkInfoScreen extends StatefulWidget {
  const AkkInfoScreen({Key? key}) : super(key: key);

  @override
  State<AkkInfoScreen> createState() => _AkkInfoScreenState();
}

class _AkkInfoScreenState extends State<AkkInfoScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(text: "Информация об аккаунте", context: context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(4),
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Имя пользователя',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 70, 70, 70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F8FF),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Симонова Алла Витальевна',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.create,
                                    color: Colors.black,
                                    size: 16,
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Номер телефона',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 70, 70, 70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F8FF),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                '+7 916 123 45 67',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.create,
                                    color: Colors.black,
                                    size: 16,
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Город',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 70, 70, 70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F8FF),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Санкт-Петербург',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.create,
                                    color: Colors.black,
                                    size: 16,
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Почта',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 70, 70, 70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F8FF),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Start782@yandex.ru',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.create,
                                    color: Colors.black,
                                    size: 16,
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
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.95),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'СНИЛС',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 70, 70, 70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F8FF),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                '142-667-877 31',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Icon(
                                    Icons.create,
                                    color: Colors.black,
                                    size: 16,
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
                        child: GestureDetector(
                          onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewPasswordScreen()),
    );
  },
                          child: Row(
                            children: const [
                              IconButton(
                                  icon: Icon(
                                    Icons.delete_forever_sharp,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: null),
                              Text(
                            'Изменить пароль для входа',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: null),
                           ],
                          ),
                        ),
                      )),

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
                        child: GestureDetector(
                          onTap: () {
                            showCancelDialog(context);
                          },
                          child: Row(
                            children: const [
                              IconButton(
                                  icon: Icon(
                                    Icons.delete_forever_sharp,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: null),
                              Text(
                                'Удалить аккаунт',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                  onPressed: null),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Контейнер для чекбокса
                        Container(
                          width: 24,
                          height: 24,
                          child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.transparent,
                              ),
                              child: Checkbox(
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                value: isChecked,
                                shape: const CircleBorder(),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              )),
                        ),

                        // Текст с красной звездочкой
                        const SizedBox(width: 8),

                        // Красная звездочка
                        Container(
                          width: 12,
                          height: 12,
                          child: const Icon(
                            Icons.star,
                            color: Colors.red,
                            size: 8,
                          ),
                        ),
                        // Текст
                        const Text(
                          'Согласен на обработку персональных данных',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Кнопка отмены
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(
                                color: const Color.fromARGB(255, 96, 159, 222)),
                          ),
                          child: Text(
                            'Отмена',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ),
                      ),

                      // Кнопка выхода
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Здесь добавьте логику выхода из приложения
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 96, 159, 222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Выйти',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ),
                      ),
                    ],
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

void showCancelDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dcontext) {
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
                  'Вы точно хотите удалить аккаунт?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Это займет до 30 дней. Вместе с профилем мы удалим личные данные, медкарту, архив записей, избранное.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomButton(
                  width: double.infinity,
                  text: "Продолжить",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () async {
                    print("continuing");
                    await showLoadingDialog(dcontext);
                    print("awaited");

                    Navigator.pop(dcontext);
                    showRescheduleDialog(dcontext);
                    Future.delayed(const Duration(seconds: 3)).then((_) {
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (dcontext) => SignInBlankScreen()),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  width: double.infinity,
                  text: "Отменить",
                  variant: ButtonVariant.FillBlueA400,
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.of(dcontext).pop();
                    //  Navigator.pushReplacement(context,
                    //      MaterialPageRoute(builder: (context) => HomeScreen()));
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
              children: const [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 125, 171, 223),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Удаление..',
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
  logOut();
  print("logged out");
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext deleteContext) {
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
                Center(
                  child: Image.asset(
                    'assets/images/Vector.png', // Замените на путь к вашему изображению
                    width: 150, // Настройте размер под ваши нужды
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Аккаунт успешно удален',
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
