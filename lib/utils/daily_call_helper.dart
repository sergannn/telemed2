import 'dart:convert';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/daily/main.dart';
import 'package:doctorq/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> launchDailyCall(
  BuildContext context,
  DailyCallMode mode,
) async {
  final appointment = context.selectedAppointment;
  if (appointment == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Не удалось определить запись.')),
    );
    return;
  }

  await requestPermissions();

  dynamic roomData = appointment['room_data'];
  String? roomUrl;
  bool roomExpired = false;

  Map<String, dynamic>? parsedRoom;
  if (roomData != null && roomData.toString().isNotEmpty && roomData != 'null') {
    try {
      if (roomData is Map<String, dynamic>) {
        parsedRoom = roomData;
      } else {
        parsedRoom = jsonDecode(roomData.toString()) as Map<String, dynamic>;
      }

      final config = parsedRoom?['config'];
      final exp = config is Map<String, dynamic> ? config['exp'] : null;
      if (exp is int) {
        final expDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        roomExpired = expDate.isBefore(DateTime.now());
      }

      final parsedUrl = parsedRoom?['url'];
      if (parsedUrl is String && parsedUrl.isNotEmpty) {
        roomUrl = parsedUrl;
      }
    } catch (e) {
      debugPrint('Error parsing room_data: $e');
    }
  }

  if (roomUrl == null || roomExpired) {
    roomUrl = 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81';
    final message = roomExpired
        ? 'Комната истекла, используем тестовую комнату.'
        : 'Не найдено данных комнаты, используется тестовая комната.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  try {
    final prefs = await SharedPreferences.getInstance();
    final client = await CallClient.create();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DailyApp(
          appointment_unique_id:
              appointment['appointment_unique_id']?.toString() ?? 'unknown',
          room: roomUrl!,
          prefs: prefs,
          callClient: client,
          mode: mode,
        ),
      ),
    );
  } catch (e) {
    debugPrint('Error launching Daily call: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Не удалось открыть комнату: $e')),
    );
  }
}
