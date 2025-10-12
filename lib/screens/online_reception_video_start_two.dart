import 'package:doctorq/screens/articles/articles.dart';
import 'package:doctorq/screens/online_reception_video_complete.dart';
import 'package:doctorq/extensions.dart';
import 'package:flutter/material.dart';

class OnlineReceptionVideoStartTwo extends StatefulWidget {
  const OnlineReceptionVideoStartTwo({Key? key}) : super(key: key);

  @override
  State<OnlineReceptionVideoStartTwo> createState() =>
      _OnlineReceptionVideoStartTwoState();
}

class _OnlineReceptionVideoStartTwoState
    extends State<OnlineReceptionVideoStartTwo> {
       bool isMicrophoneEnabled = false;
       bool _isMuted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Видео с пациентом'),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${context.selectedAppointment['doctor']?['first_name'] ?? ''} ${context.selectedAppointment['doctor']?['last_name'] ?? ''}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('    ${context.selectedAppointment['doctor']?['specialization'] ?? 'Врач'}',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 136, 136, 136),
                                            fontSize: 12)),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        Center(
  child: Container(
    width: 230,
    height: 330,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Image.asset(
      'assets/images/forvideo.png',
      fit: BoxFit.contain,
    ),
  ),
)
                        ]),
                  ),
                )),

// Секция с таймером и кнопками внизу экрана
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '00:00 мин',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Кнопка громкая связь
                         Column(
  children: [
    Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _isMuted ? Color(0xFFE4F0FF) : Color(0xFF81AEEA),
      ),
      child: IconButton(
        icon: Icon(
          _isMuted ? Icons.volume_off : Icons.volume_up,
          color: _isMuted ? Colors.black87 : Colors.white,
        ),
        onPressed: () {
          setState(() {
            _isMuted = !_isMuted;
          });
        },
      ),
    ),
    const SizedBox(height: 4),
    Text(
      'Громкая \nсвязь',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10),
    ),
  ],
),
                          // Кнопка микрофона
                          Column(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isMicrophoneEnabled 
                                      ? Color(0xFFE4F0FF) : Color(0xFF81AEEA),
                                ),
                                child: IconButton(
                                  icon: Icon(isMicrophoneEnabled
                                      ? Icons.mic_off
                                      : Icons.mic_none,
                                    color: isMicrophoneEnabled
                                        ? Colors.black87
                                        :  Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      isMicrophoneEnabled =
                                          !isMicrophoneEnabled;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Микрофон',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          // Кнопка отмены
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
                                  icon: Icon(Icons.close,
                                      color: Colors.white),
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
                          // Кнопка медкарты
                          Column(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFE4F0FF),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.man,
                                      color: Colors.black87),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Доступ \nк медкарте',
                                textAlign: TextAlign.center,
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
