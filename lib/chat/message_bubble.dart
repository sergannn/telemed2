import 'package:flutter/material.dart';
import 'chat_message_model.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageModel message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}