// Заглушка для Daily на веб-платформе
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DailyCallMode {
  video,
  audio,
  chat,
}

class DailyApp extends StatefulWidget {
  const DailyApp({
    super.key,
    required this.prefs,
    required this.callClient,
    required this.room,
    required this.appointment_unique_id,
    this.mode = DailyCallMode.video,
  });

  final SharedPreferences prefs;
  final dynamic callClient;
  final String room;
  final String appointment_unique_id;
  final DailyCallMode mode;

  @override
  State<DailyApp> createState() => _DailyAppState();
}

class _DailyAppState extends State<DailyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Видеозвонок'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.videocam_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Видеозвонки недоступны в веб-версии',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Используйте мобильное приложение для видеозвонков',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Вернуться назад'),
            ),
          ],
        ),
      ),
    );
  }
}

