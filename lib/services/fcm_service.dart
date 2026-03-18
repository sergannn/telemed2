import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:doctorq/services/session.dart';
import 'package:doctorq/utils/utility.dart';

// Обработчик фоновых сообщений — должен быть top-level функцией
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('FCM background message: ${message.messageId}');
}

class FcmService {
  static final FcmService _instance = FcmService._internal();
  factory FcmService() => _instance;
  FcmService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const _backendUrl = 'https://admin.onlinedoctor.su';

  Future<void> initialize() async {
    // Регистрируем обработчик фоновых сообщений
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Запрашиваем разрешение (iOS)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    printLog('FCM permission: ${settings.authorizationStatus}');

    // Показываем уведомления нативно даже когда приложение открыто (iOS)
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Инициализируем локальные уведомления для foreground
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    await _localNotifications.initialize(
      const InitializationSettings(
          android: androidSettings, iOS: iosSettings),
    );

    // Создаём канал уведомлений (Android)
    const channel = AndroidNotificationChannel(
      'appointments_channel',
      'Новые записи',
      description: 'Уведомления о новых записях на приём',
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Показываем уведомление когда приложение открыто (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printLog('FCM foreground message: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    // Получаем и сохраняем токен
    await _saveToken();

    // Обновляем токен если он изменился
    _messaging.onTokenRefresh.listen(_sendTokenToBackend);
  }

  // Вызывается после логина когда пользователь уже в сессии
  Future<void> saveTokenAfterLogin() async {
    await _saveToken();
  }

  Future<void> _saveToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        printLog('FCM token: $token');
        await _sendTokenToBackend(token);
      }
    } catch (e) {
      printLog('Error getting FCM token: $e');
    }
  }

  Future<void> _sendTokenToBackend(String token) async {
    try {
      final user = await Session.getCurrentUser();
      if (user == null) {
        printLog('FCM: no user, token not saved');
        return;
      }

      final response = await http.post(
        Uri.parse('$_backendUrl/api/device-tokens'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': int.tryParse(user.userId ?? '') ?? 0,
          'device_id': token, // используем FCM token как уникальный device_id
          'fcm_token': token,
          'platform': 'ios',
        }),
      );
      printLog('FCM token saved to backend: ${response.statusCode} ${response.body}');
    } catch (e) {
      printLog('Error sending FCM token to backend: $e');
    }
  }

  void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'appointments_channel',
          'Новые записи',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
