import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class PopularDoctorsScreen extends StatelessWidget {
  const PopularDoctorsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...topBack("Запись к врачу", context),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.all(6),
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
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 236, 236)
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
                            icon: const Icon(Icons.search,
                                color: Color.fromARGB(255, 131, 131, 131),
                                size: 24),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Найти врача',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),
                          const Spacer(), // раздвигает элементы
                          IconButton(
                            icon: const Icon(Icons.mic,
                                color: Color.fromARGB(255, 131, 131, 131),
                                size: 22),
                            onPressed: () {}, //обработчик нажатия
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      Text(
                                        'Популярные врачи',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Акушер',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      const SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Акушер-гинеколог',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      const SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Анколог',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // выравнивание всех чилдренов внутри коламн по левому краю
                                    children: [
                                      const SizedBox(
                                          height:
                                              10), // добавлен SizedBox с отступом 16 пикселей
                                      Text(
                                        'Бактериолог',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 12, 12, 12),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // Зеленый контейнер
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247)
                                          .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/images/11.png'), // Используем AssetImage вместо Image.asset
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text('Парфенов К.С.',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('Акушер-гинеколог'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    255, 176, 214, 254),
                                              ),
                                              constraints: const BoxConstraints(
                                                  minWidth: 10, minHeight: 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.currency_ruble,
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                  ),
                                                  const Text('2300',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 16, 16, 16),
                                                          fontSize: 11)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8), // Отступ между строками
                                    Container(
                                      width: double.infinity, // Полная ширина
                                      height: 40, // Высота изображения
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            12), // Закругленные углы
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
