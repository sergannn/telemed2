import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/articles/articles.dart';
import 'package:doctorq/screens/online_reception_video_complete.dart';
import 'package:doctorq/screens/online_reception_video_start_two.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';




class OnlineReceptionVideoStart extends StatefulWidget {
  const OnlineReceptionVideoStart({super.key, required this.title});
  final String title;

  @override
  State<OnlineReceptionVideoStart> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OnlineReceptionVideoStart> {
  final meetingNameController = TextEditingController();
  final jitsiMeet = JitsiMeet();
  void join() {

    var options = JitsiMeetConferenceOptions(
      serverURL: "https://meet.engagemedia.org",
      room: "test0987test",
      configOverrides: {
        "startWithAudioMuted": true,
        "startWithVideoMuted": true,
        "subject" : "JitsiwithFlutter",
        "localSubject" : "localJitsiwithFlutter",
      },
      featureFlags: {
        "unsaferoomwarning.enabled": false,
        "security-options.enabled": false
      },
      userInfo: JitsiMeetUserInfo(
          displayName: "Flutter user",
          email: "user@example.com"
      ),
    );
    jitsiMeet.join(options);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                controller: meetingNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите имя',
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: FilledButton(
                onPressed: join,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                ),
                child: const Text("Подключиться")
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class OnlineReceptionVideoStart2 extends StatefulWidget {
  const OnlineReceptionVideoStart2({Key? key}) : super(key: key);

  @override
  State<OnlineReceptionVideoStart2> createState() => _OnlineReceptionVideoStartState();
}

class _OnlineReceptionVideoStartState extends State<OnlineReceptionVideoStart2> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Видео с врачом'),
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
                                  backgroundImage:
                                      NetworkImage(context.selectedAppointment['doctor']['photo']),
                                ),
                                const SizedBox(width: 16),
                                      Text(
                                         context.selectedAppointment['doctor']['username'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if(context.selectedAppointment['doctor']['specializations'].isNotEmpty)
                                        Text(
                                          context.selectedAppointment['doctor']['specializations'][0]['name'],
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 136, 136, 136),
                                            fontSize: 12 
                                          )),
                                      const SizedBox(height: 4), // Добавляем отступ между строками
const Text(
'Звонит по видео ...',
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


// Новая секция с таймером и кнопками
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
                                        builder: (context) => const OnlineReceptionVideoStartTwo(),
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
