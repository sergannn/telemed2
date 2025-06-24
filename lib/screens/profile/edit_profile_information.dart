import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/profile/main_profile.dart';
import 'package:doctorq/utils/size_utils.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class AkkEditScreen extends StatefulWidget {
  const AkkEditScreen({Key? key}) : super(key: key);

  @override
  State<AkkEditScreen> createState() => _AkkInfoScreenState();
}

class _AkkInfoScreenState extends State<AkkEditScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack(text: "Редактирование профиля", context: context, icon: Icon(Icons.edit)),
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
                          borderRadius: BorderRadius.only(
      topLeft: Radius.circular(22), // Скругление верхнего левого угла
      topRight: Radius.circular(22), // Скругление верхнего правого угла
    ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: getVerticalSize(25),
                            backgroundImage:
                                NetworkImage(context.userData['photo']),
                          ),

                          HorizontalSpace(width: 20),

                          //child: FittedBox(
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainProfileScreen()),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: context.userData['first_name'] +
                                      ' ' +
                                      context.userData['last_name'] +
                                      '\n',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '3 близких' +
                                          // context.userData['patient_id'] +
                                          "",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 40),
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
                                'ФИО',
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
                                'Дата рождения',
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
                                '03.10.1994',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                
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
                          borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(22), // Скругление нижнего левого угла
      bottomRight: Radius.circular(22), // Скругление нижнего правого угла
    ),
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
                               
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
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
                            'Отменить',
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
                            'Сохранить',
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
