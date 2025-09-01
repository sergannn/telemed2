import 'package:doctorq/screens/articles/articles.dart';
import 'package:doctorq/screens/online_reception_audio_complete.dart';
import 'package:doctorq/screens/online_reception_audio_start_two.dart';
import 'package:doctorq/extensions.dart';
import 'package:flutter/material.dart';

class OnlineReceptionAudioStart extends StatefulWidget {
  const OnlineReceptionAudioStart({Key? key}) : super(key: key);

  @override
  State<OnlineReceptionAudioStart> createState() => _OnlineReceptionAudioStartState();
}

class _OnlineReceptionAudioStartState extends State<OnlineReceptionAudioStart> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аудио с пациентом'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок над чатом
             Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 4, right: 24),
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
                           
                            const SizedBox(height: 56),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                  radius: 30,
                                  backgroundImage: context.selectedAppointment['doctor']?['profile_image'] != null
                                      ? NetworkImage(context.selectedAppointment['doctor']?['profile_image'])
                                      : AssetImage('assets/images/11.png') as ImageProvider,
                                ),
                                const SizedBox(width: 16),
                                      Text(
                                        '${context.selectedAppointment['doctor']?['first_name'] ?? ''} ${context.selectedAppointment['doctor']?['last_name'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        context.selectedAppointment['doctor']?['specialization'] ?? 'Врач',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 136, 136, 136),
                                         fontSize: 12 
                                        )),
                                      const SizedBox(height: 4), // Добавляем отступ между строками
const Text(
'Звонит ...',
style: TextStyle(
fontSize: 12,
color: Color.fromARGB(255, 46, 46, 46),
),
),
const SizedBox(height: 4), // Добавляем отступ между строками

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
           
              ]
            ),
          ),
              )),

// Контейнер c изображением
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Image.asset(
          'assets/images/Audio.png',
          width: double.infinity,
          height: 150, 
          fit: BoxFit.contain,
        ),
      ),
    ),
    

// Секция с таймером и кнопками
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '00:00 мин',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF81AEEA),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt, color: Colors.white),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OnlineReceptionAudioStartTwo(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Принять\nвызов',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF83D39),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.close, color: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Отмена',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
