import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'chat_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'websocket_server.dart';
import 'proactivity/notification_trigger.dart';
import 'web_server.dart';

const bool enableNotificationTrigger = false;

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("hello");

    // const color = Color.fromARGB(255, 241, 241, 241);
    return Scaffold(
      //backgroundColor:
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 212, 212),
        title: Row(
          children: [
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.library_add), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // Бу, не бойся! обоберни только прокручиваемую часть)
              child: Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 212, 212, 212),
                    height: 130,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const ServiceCard(
                            title: '', imagePath: 'assets/images/service1.jpg'),
                        const ServiceCard(
                            title: '', imagePath: 'assets/images/service2.jpg'),
                        const ServiceCard(
                            title: '', imagePath: 'assets/images/service3.jpg'),
                        const ServiceCard(
                            title: '', imagePath: 'assets/images/service4.jpg'),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                        //     border: Border.all(
                        //    width: 1.0, // Adjust this value to change the border width
                        color: const Color.fromARGB(255, 212, 212, 212),
                      ),
//  color:  Color.fromARGB(255, 212, 212, 212),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            border: Border.all(
                              width:
                                  1.0, // Adjust this value to change the border width
                              color: const Color.fromARGB(255, 255, 255,
                                  255), // Adjust this color as needed
                            ), // Add any other decorations if needed
                          ),
                          child: Column(children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    '+7 916 123 45 67',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text('Баланс: 142,07 ₽',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04), // Бу, не бойся, отступ от правого края тут)
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 230, 53, 53),
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    onPressed: () {
//Fluttertoast.showToast(msg: msg)
                                      Fluttertoast.showToast(
                                          msg: "Баланс нельзя пополнить",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: const Color.fromARGB(
                                              255, 230, 53, 53),
                                          textColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 24.0);
                                    },
                                    child: const Text(
                                      'Пополнить',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 170,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Расходы в декабре 0 ₽',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                      const SizedBox(height: 35),
                                      Container(
                                        height: 3,
                                        width: 130,
                                        color: const Color.fromARGB(
                                            255, 213, 213, 213),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          'Подключенные услуги\nи сервисы', // Бу, запомни! Перенос "и" на новую строку
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 19,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 213, 213, 213),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Center(
                                          child: Text('...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  0.9, // Не на всю ширину экрана
                              height: 110,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          'СЛУЖЕБНЫЙ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Text('>',
                                            style: TextStyle(fontSize: 22)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text('49,99 ГБ',
                                              textAlign: TextAlign.center),
                                          Container(
                                            height: 1,
                                            width: 80,
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                          ),
                                          const Text('ГБ',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text('По тарифу',
                                              textAlign: TextAlign.center),
                                          Container(
                                            height: 1,
                                            width: 80,
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                          ),
                                          const Text('Минуты',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text('По тарифу',
                                              textAlign: TextAlign.center),
                                          Container(
                                            height: 1,
                                            width: 80,
                                            color: const Color.fromARGB(
                                                255, 213, 213, 213),
                                          ),
                                          const Text('Сообщения',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  0.9, // Не на всю ширину экрана
                              height: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/banner1.jpg'), // Замените на изображение-баннер
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                  child: Text('Баннер',
                                      style: TextStyle(color: Colors.white))),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 120, // Бу, не на всю ширину экрана
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 17),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/icon1.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      const Text('ЗАЩИТНИК'),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: const Text('>',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  Row(
                                    children: [
                                      const SizedBox(width: 24),
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/icon2.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Начните отслеживать утечки'),
                                    ],
                                  ),
                                  const Divider(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  Row(
                                    children: [
                                      const SizedBox(width: 24),
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/icon2.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Определитель выключен'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ])))
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'мой МТС'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: 'Расходы'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Каталог'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.assistant), label: 'Ассистент'),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 3) {
            // Бу, индекс для "Ассистент"
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen()), // Бу, переход на экран чат-бота
            );
          }
        },
      ),
    );
  }

  Widget ___oldbuild(BuildContext context) {
    return MaterialApp(
      title: 'MTS RnD GenUI/UX App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const ServiceCard({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Бу, тапаем на функциональность
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Смотрите новости в актуальном приложении МОЙ МТС. $title'),
              actions: [
                TextButton(
                  child: const Text('Закрыть'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold), // Бу, лучшая видимость
          ),
        ),
      ),
    );
  }
}
