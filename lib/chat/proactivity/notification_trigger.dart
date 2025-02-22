import 'package:flutter/material.dart';
//import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'dart:isolate';
import 'dart:ui';
import 'dart:convert';
import '../proactivity/proactivity_manager.dart';
/*
class NotificationTrigger {
  static const String isolateName = "NotificationIsolate";

  static Future<void> initialize() async {
// Проверяем разрешение Notification Listener
    final bool? hasPermission = await NotificationsListener.hasPermission;
    if (hasPermission != null && hasPermission) {
      print("Notification Listener permission granted");
      _startListening();
    } else {
      print("Notification Listener permission not granted, requesting...");
      // Запрашиваем разрешение
      await NotificationsListener.openPermissionSettings();
      // После возвращения из настроек, проверяем разрешение еще раз
      final bool? hasPermissionAfterRequest = await NotificationsListener.hasPermission;
      if (hasPermissionAfterRequest != null && hasPermissionAfterRequest) {
        print("Notification Listener permission granted after request");
        _startListening();
      } else {
        print("Notification Listener permission denied");
      }
    }
  }

  static Future<void> _startListening() async {
    final ReceivePort receivePort = ReceivePort();

    // Регистрация порта
    final bool registered = IsolateNameServer.registerPortWithName(
        receivePort.sendPort, isolateName);
    print("Port registered: $registered with name: $isolateName");

    receivePort.listen((dynamic message) {
      print("Received in initialize listener: $message");
      if (message is String) {
        try {
          final Map<String, dynamic> decodedMessage = jsonDecode(message);
          _handleNotificationEvent(decodedMessage);
        } catch (e) {
          print("Error decoding message: $e");
        }
      }
    });

    NotificationsListener.initialize(callbackHandle: _callback);

    // Запускаем сервис
    final result = await NotificationsListener.startService(
      foreground: true,
      title: "Служба проактивности",
      description: "Отслеживает уведомления",
    );
    print("NotificationsListener service started with result: $result");
  }

  @pragma('vm:entry-point')
  static void _callback(NotificationEvent evt) {
    print("Received event: $evt");
    final SendPort? sendPort = IsolateNameServer.lookupPortByName(isolateName);
    if (sendPort != null) {
      print(
          "Event details: PackageName=${evt.packageName}, Title=${evt.title}, Text=${evt.text}, Timestamp=${evt.timestamp}, Key=${evt.key}");
      final Map<String, dynamic> eventMap = {
        'packageName': evt.packageName,
        'title': evt.title,
        'text': evt.text,
        'timestamp': evt.timestamp?.toString(),
        'key': evt.key,
      };
      print("Prepared eventMap: $eventMap");
      final jsonString = jsonEncode(eventMap);
      print("Sending to UI: $jsonString");
      sendPort.send(jsonString);
    } else {
      print("No sendPort found for isolate.");
    }
  }

  static void _handleNotificationEvent(Map<String, dynamic> eventMap) {
    print("_handleNotificationEvent called with: $eventMap");
    final String packageName = eventMap['packageName'] ?? 'Unknown package';
    final String title = eventMap['title'] ?? 'No title';
    final String text = eventMap['text'] ?? 'No text';

    // print("______________________________________");
    // print("packageName: $packageName");
    // print("title: $title");
    // print("text: $text");
    // print("______________________________________");

    // Проверяем, что уведомление от Telegram
    if (packageName == 'org.telegram.messenger') {
      final trigger = ProactivityTrigger(
        'notification from $packageName',
        '$title: $text',
      );

      ProactivityManager().addTrigger(trigger);
    }
  }
}*/
