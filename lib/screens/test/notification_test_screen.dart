import 'package:flutter/material.dart';
import 'package:doctorq/services/notification_service.dart';

class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({super.key});

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  final NotificationService _notificationService = NotificationService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _testImmediateNotification() async {
    if (!_isInitialized) return;

    await _notificationService.showTestNotification(
      'Тестовое уведомление',
      'Это тестовое уведомление для проверки работы сервиса!'
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Тестовое уведомление отправлено!'))
    );
  }

  Future<void> _testScheduledNotification() async {
    if (!_isInitialized) return;

    // Создаем фейковую запись на завтра
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final fakeAppointment = {
      'id': 'test_scheduled_${DateTime.now().millisecondsSinceEpoch}',
      'patient': {
        'patientUser': {
          'full_name': 'Тестовый Пациент (напоминание)'
        }
      },
      'from_time': '14:00',
      'from_time_type': 'PM',
      'to_time': '15:00',
      'to_time_type': 'PM',
      'date': tomorrow.toString(),
    };

    await _notificationService.scheduleAppointmentReminder(fakeAppointment);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Напоминание запланировано на завтра!'))
    );
  }

  Future<void> _cancelAllNotifications() async {
    if (!_isInitialized) return;
    
    await _notificationService.cancelAllNotifications();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Все уведомления отменены!'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест Уведомлений'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Статус: ${_isInitialized ? "Инициализирован" : "Загрузка..."}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testImmediateNotification,
              child: const Text('Тест мгновенного уведомления'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testScheduledNotification,
              child: const Text('Тест запланированного напоминания'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _cancelAllNotifications,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Отменить все уведомления'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Примечание: Для iOS нужно добавить разрешения в Info.plist:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Text(
              '- UILaunchScreen\n- UNUserNotificationCenter',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
