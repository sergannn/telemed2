import 'package:doctorq/screens/articles/articles.dart';
import 'package:doctorq/screens/online_reception_chat_complete.dart';
import 'package:flutter/material.dart';

class OnlineReceptionChatStart extends StatefulWidget {
  const OnlineReceptionChatStart({Key? key}) : super(key: key);

  @override
  State<OnlineReceptionChatStart> createState() => _OnlineReceptionChatStartState();
}

class _OnlineReceptionChatStartState extends State<OnlineReceptionChatStart> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text,
          'isMe': true,
          'timestamp': DateTime.now(),
        });
        _messages.add({
          'text': 'Сообщение от врача появится здесь...',
          'isMe': false,
          'timestamp': DateTime.now(),
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: AssetImage('assets/images/11.png'),
                  ),
                  const SizedBox(width: 12),
                  // Информация о враче
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const Text(
                                        'Парфенова К.С.',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                         const Text(
                                        'Женщина, 71',
                                        style: TextStyle(
                                         fontSize: 12 
                                        ),),
                                         const SizedBox(height: 4), 
                                          
const Text(
'7:05 мин',
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
      MaterialPageRoute(builder: (context) => const OnlineReceptionChatComplete()),
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
                            'Кнопка перехода на экран завершения приема в чате, а так следующий экран должен открываться после того, как чат завершен"',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
              ]
            ),
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
                    alignment: message['isMe']
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
                        color: message['isMe']
                            ? const Color.fromARGB(255, 228, 240, 255)
                            : const Color.fromARGB(255, 244, 246, 249)
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                          color: message['isMe']
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
        icon: Icon(Icons.send, color: Color.fromARGB(255, 129, 174, 234)),
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