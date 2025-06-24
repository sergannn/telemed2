import 'package:doctorq/screens/profile/about_app.dart';
import 'package:doctorq/screens/profile/akk_information.dart';
import 'package:doctorq/screens/profile/data_usage.dart';
import 'package:doctorq/screens/profile/legal_information.dart';
import 'package:doctorq/widgets/top_back.dart';
import 'package:flutter/material.dart';

class SettingsAllScreen extends StatefulWidget {
  const SettingsAllScreen({Key? key}) : super(key: key);

  @override
  State<SettingsAllScreen> createState() => _SettingsAllScreenState();
}

class _SettingsAllScreenState extends State<SettingsAllScreen> {
  bool _notificationsEnabled = false;
  bool _themeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ...topBack(text: "Настройки", context: context, height: 0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 236, 236).withOpacity(0.95),
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(22), // Скругление верхнего левого угла
      topRight: Radius.circular(22), // Скругление верхнего правого угла
    ),
                      ),
                      child: GestureDetector(
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
                                  Icons.medical_information_sharp,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onPressed: null,
                              ),
                              const Text(
                                'Информация об аккаунте',
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const AkkInfoScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const AkkInfoScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
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
                                Icons.notification_add_sharp,
                                color: Colors.black,
                                size: 20,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              'Уведомления',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: _notificationsEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _notificationsEnabled = value;
                                  // Логику сюда
                                  // при изменении состояния уведомлений
                                });
                              },
                              activeColor: Colors.blue,
                              activeTrackColor: Colors.blue.withOpacity(0.5),
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
                    child: 
                                              //child: FittedBox(
GestureDetector(onTap:() {

  Navigator.push(context, MaterialPageRoute(builder: (context) =>

  DataUsageScreen()

));

}, child:
                    
                    Container(
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
                              Icons.data_usage_sharp,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Использование данных',
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
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )),
                  ),

          GestureDetector(onTap:() {

  Navigator.push(context, MaterialPageRoute(builder: (context) =>

  LegalInformationScreen()

));

}, child:        
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
                              Icons.perm_device_information_sharp,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Юридическая информация',
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
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  )),

                  GestureDetector(onTap:() {

  Navigator.push(context, MaterialPageRoute(builder: (context) =>

  AboutAppScreen()

));

}, child:   
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
                              Icons.app_shortcut_sharp,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'О приложении',
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
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  )),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.95),
                        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(22), // Скругление нижнего левого угла
      bottomRight: Radius.circular(22), // Скругление нижнего правого угла
    ),
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
                                Icons.brightness_4_sharp,
                                color: Colors.black,
                                size: 20,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              'Тема',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: _themeEnabled,  // Отделились
                              onChanged: (value) {
                                setState(() {
                                  _themeEnabled = value;
                                  // Логику сюда
                                });
                              },
                              activeColor: Colors.blue,
                              activeTrackColor: Colors.blue.withOpacity(0.5),
                            ),
                          ],
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
    );
  }
}