import 'package:flutter/material.dart';

class ChatMessageModel {
  final String text;
  final bool isUser;
  final bool isTool;
  final Widget? toolWidget;
  final String? toolSummary;
  final Key key; // Добавьте это поле

  ChatMessageModel({
    required this.text,
    required this.isUser,
    this.isTool = false,
    this.toolWidget,
    this.toolSummary,
    Key? key, // Добавьте этот параметр
  }) : key = key ?? UniqueKey(); // Если ключ не предоставлен, создайте новый

  @override
  String toString() {
    return '{'
        '"text": "$text", '
        '"isUser": $isUser, '
        '"isTool": $isTool, '
        '"toolWidget": ${toolWidget != null ? toolWidget.toString() : 'null'}, '
        '"toolSummary": ${toolSummary ?? 'null'}'
        '}';
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'isTool': isTool,
      'toolSummary': toolSummary,
      // Мы не можем сериализовать Widget, поэтому просто указываем, есть ли он
      'hasToolWidget': toolWidget != null,
    };
  }
}