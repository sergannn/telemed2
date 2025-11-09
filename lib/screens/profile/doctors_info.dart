import 'package:flutter/material.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //const SizedBox(height: 40), // фиксированный отступ
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
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'О враче',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог, гинеколог, гинеколог-эндокринолог, 47 отзывов пациентов, места работы, кандидат наук, высшая категория, стаж 38 лет, запись на приём.',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Образование',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог, гинеколог, гинеколог-эндокринолог, 47 отзывов пациентов, места работы, кандидат наук, высшая категория, стаж 38 лет, запись на приём. Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог, гинеколог, гинеколог-эндокринолог, 47 отзывов пациентов, места работы, кандидат наук, высшая категория, стаж 38 лет, запись на приём. Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог, гинеколог, гинеколог-эндокринолог, 47 отзывов пациентов, места работы, кандидат наук, высшая категория, стаж 38 лет, запись на приём.',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Специальность',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Михайлюк кцкцуекн рнреор лрпопрлдлодджлжд лрод Михайлюк кцкцуекн рнреор лрпопрлдлодджлжд лрод',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Профиль лечения',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Стаж работы',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  'Михайлюк Галина Ивановна, Санкт-Петербург: онколог-гинеколог, гинеколог, гинеколог-эндокринолог, 47 ',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Отзывы пациентов',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Row с иконкой и текстом
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.star,
                                      color: Color(0xFFFFD700), size: 24),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '4.3',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 17, 17, 17),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Мнение пациентов',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 17, 17, 17),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.star,
                                      color: Color(0xFFFFD700), size: 18),
                                  Icon(Icons.star,
                                      color: Color(0xFFFFD700), size: 18),
                                  Icon(Icons.star,
                                      color: Color(0xFFFFD700), size: 18),
                                  Icon(Icons.star,
                                      color: Color(0xFFFFD700), size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '5 февраля 2024',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 17, 17, 17),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Комментарии',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 17, 17, 17),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Сразу понятно что врач очень грамотный и компетентный. Консультация прошла на 5 баллов - я все узнала о своем здоровье!',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 17, 17, 17),
                                        fontSize: 12,
                                      ),
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
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Row для даты и иконки
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Документы',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 19, 19, 19),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Зеленый контейнер
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xF4F8FF).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Описание
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 17, 17, 17),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              // Кнопка и время
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
