import 'package:doctorq/screens/articles/articles.dart';
import 'package:doctorq/screens/online_reception_audio_start.dart';
import 'package:flutter/material.dart';

class OnlineReceptionAudio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ближайшие записи'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // Добавляем это
        child: Container(
          width: double.infinity, // Добавляем это
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 4, right: 24),
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
                                    Icons.message_outlined,
                                    size: 14,
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Онлайн прием',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 17, 17, 17),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(), // Добавляем Spacer для отступа
    Text(
      'Сегодня',
      style: TextStyle(
        color: const Color.fromARGB(255, 136, 136, 136), // Серый цвет
        fontSize: 12,
      ),
    ),
                              ],
                            ),
                            const SizedBox(height: 26),

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
                                        color: const Color.fromARGB(255, 218, 236, 255),
                                        borderRadius:
                                            BorderRadius.circular(18),
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
                                        color: const Color.fromARGB(255, 218, 236, 255),
                                        borderRadius:
                                            BorderRadius.circular(18),
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
SizedBox(height: 20),
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
                                      const Text(
                                         'Парфенов К.С.',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Акушер-гинеколог',
                                        style: TextStyle(
                                         fontSize: 12 
                                        )),
                                      const SizedBox(height: 4), // Добавляем отступ между строками
const Text(
'Чат / онлайн консультация',
style: TextStyle(
fontSize: 10,
color: Color.fromARGB(255, 136, 136, 136),
),
),
const SizedBox(height: 4), // Добавляем отступ между строками
Row(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Icon(
Icons.arrow_back,
size: 14,
color: Color.fromARGB(255, 0, 0, 0),
),
const SizedBox(width: 4),
Text(
'45 мин',
style: TextStyle(
fontSize: 11,
color: Color.fromARGB(255, 0, 0, 0),
),
),
],
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
                            const SizedBox(height: 18),
                            // Заменяем изображение на два контейнера с информацией
                          Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    // Текст "Успешно оплачено"
    Text(
      'Успешно оплачено',
      style: TextStyle(
        color: Color.fromARGB(255, 16, 16, 16),
        fontSize: 14,
      ),
    ),
    
    // Spacer для отступа между текстом и суммой
    const Spacer(),
    
    // Контейнер с голубым фоном для суммы
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 218, 236, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.currency_ruble,
            size: 12,
            color: Color.fromARGB(255, 47, 122, 186),
          ),
          Text(
            '1000',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 16, 16, 16),
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  ],
),
                              const SizedBox(height: 14),

Container(
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
       
                                // Описание
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    'Мы напомним вам о предстоящем приеме за 1 час до назначенного времени. Важно помнить, что кнопка “Начать прием” будет доступна за 10 мин до приема. Также, вы сможете предоставить “Доступ к медкарте” врачу за 10 мин до приема, чтобы он смог заранее ознакомиться с вашей историей здоровья. Будьте внимательны, не пропускайте уведомления о важных событиях.',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 12),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Основная кнопка слева
    ElevatedButton(
      onPressed: () {
         Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnlineReceptionAudioStart()),
    );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 96, 159, 222),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        minimumSize: Size(180, 51),
      ),
      child: Text(
        'Начать прием',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    ),
    // Круглая кнопка справа
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 51,
          height: 51,
          margin: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 96, 159, 222),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.medical_information),
            color: Colors.white,
            padding: EdgeInsets.zero,
            iconSize: 20,
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedCardScreen()),
    );
            },
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Доступ к медкарте',
          style: TextStyle(
            fontSize: 10,
            color: Color.fromARGB(255, 17, 17, 17),
          ),
        ),
      ],
    ),
  ],
),
             SizedBox(height: 12),

            
       
                                // Описание
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    'Вы можете отменить запись к данному врачу, перейдя по кнопке “Отмена записи”. Возврат средств обычно занимает до 15 календарных дней. Важно помнить, что отменить запись можно не позднее, чем за 2 часа до начала приема. В противном случае, мы не сможем осуществить возврат  денег.',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 12),
                                
                                
                               ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 96, 159, 222),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 12, 
      vertical: 8,
    ),
    minimumSize: Size(0, 51), 
  ),
  child: Text(
    'Отменить запись',
    style: TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
  ),
),
                        SizedBox(height: 100), // 'ЭТОТ КОЛХОЗ НАДО УБРАТЬ И СДЕЛАТЬ ПО-ЧЕЛОВЕЧЕСКИ ЧТОБЫ МЕНЮ НЕ ЗАКРЫВАЛО КНОПКУ'
                              ],
                            ),
                          ),

                          ],
                        ),
                      ),))
                          ],
                    ),
                  ),)
              );
        
  }
}