import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/articles/articles.dart';
import 'package:doctorq/screens/online_reception_chat_complete.dart';
import 'package:doctorq/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OnlineReceptionChatStart extends StatefulWidget {
  const OnlineReceptionChatStart({Key? key}) : super(key: key);

  @override
  State<OnlineReceptionChatStart> createState() =>
      _OnlineReceptionChatStartState();
}

class _OnlineReceptionChatStartState extends State<OnlineReceptionChatStart> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  late Timer _timer;
  int _lastMessageId = 0;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    _startPolling();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      print('ping');
      _fetchMessages();
    });
  }

  Future<void> _fetchMessages() async {
    if (context.selectedAppointment != null) {
      int appointmentId = int.parse(context.selectedAppointment['id']);
      List<Map<String, dynamic>> messages =
          await SupabaseService.getMessages(appointmentId: appointmentId);
      setState(() {
        _messages = messages.map((msg) {
          msg['isMe'] =
              msg['from'].toString() == context.userData['user_id'].toString();

          // print(msg['from'].toString() +'=='+context.userData['user_id'].toString());

          return msg;
        }).toList();
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      if (context.selectedAppointment != null) {
        int fromUserId =
            int.parse(context.selectedAppointment['patient']['user_id']);
        int toUserId =
            int.parse(context.selectedAppointment['doctor']['user_id']);
        int appointmentId = int.parse(context.selectedAppointment['id']);
        String text = _messageController.text;
        print('will send message');
        var result = await SupabaseService.sendMessage(
          fromUserId: fromUserId,
          toUserId: toUserId,
          text: text,
          appointmentId: appointmentId,
        );

        if (result != null) {
          setState(() {
            result['isMe'] = true;
            _messages.add(result);
            _messageController.clear();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(context.selectedAppointment);
    print("its context");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат с врачом'),
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
                      color: const Color.fromARGB(255, 247, 247, 247)
                          .withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 26),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:  NetworkImage(context.selectedAppointment['doctor']['photo'])
//                                    AssetImage('assets/images/11.png'),
                              ),
                              const SizedBox(width: 12),
                              // Информация о враче
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      context.selectedAppointment['doctor']['username'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if( context.selectedAppointment['doctor']['specializations'].isNotEmpty)
                                     Text(
                                     context.selectedAppointment['doctor']['specializations'][0]['name'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                     Text(
                                       context.selectedAppointment['from_time'] + ' - ' +  context.selectedAppointment['to_time'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 91, 91, 91),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnlineReceptionChatComplete()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 96, 159, 222),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            child: Text(
                              'Завершить',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ]),
                  ),
                )),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  return Align(
                    alignment: message['isMe'] == true
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: message['isMe'] == true
                              ? const Color.fromARGB(255, 228, 240, 255)
                              : const Color.fromARGB(255, 244, 246, 249)),
                      child: Text(
                        message['text'] ?? 'No text',
                        style: TextStyle(
                          color: message['isMe'] == true
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Введите сообщение...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send,
                        color: Color.fromARGB(255, 129, 174, 234)),
                    onPressed: _sendMessage,
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 244, 246, 249),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
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
