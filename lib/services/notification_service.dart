import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:teledart/teledart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

GetIt getIt = GetIt.instance;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Timer? _checkingTimer;
  List<String> _knownAppointmentIds = [];
  String? _currentDoctorId;
  static const String _lastCheckKey = 'last_appointment_check';
  static const String _knownAppointmentsKey = 'known_appointment_ids';

  Future<void> initialize() async {
    // Initialize timezone database
    tz.initializeTimeZones();

    // Initialize notifications plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Initialize WorkManager for background tasks
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );

    // Load saved data
    await _loadSavedData();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
     InitializationSettings initializationSettings =
        InitializationSettings(
            iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        // Handle notification tap
        print('Notification tapped: ${notificationResponse.payload}');
      },
    );

    // Request notification permissions
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // For Android, permissions are automatically granted
    // For iOS, request notification permissions
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      
      
    }
  }

  Future<void> startCheckingForNewAppointments(String doctorId) async {
    print("checking started");
    // Stop any existing timer
    stopChecking();

    // Load initial appointments to know what we already have
    await _loadInitialAppointments(doctorId);

    // Start background polling instead of timer
    await startBackgroundPolling(doctorId);
  }

  void stopChecking() {
    _checkingTimer?.cancel();
    _checkingTimer = null;
    stopBackgroundPolling();
  }

  Future<void> _loadInitialAppointments(String doctorId) async {
    //try {
      final success = await getAppointmentsD(doctorId: doctorId);
      if (success) {
        // Проверяем, зарегистрирован ли AppointmentsStore
        if (getIt.isRegistered<AppointmentsStore>()) {
          final store = getIt.get<AppointmentsStore>();
          _knownAppointmentIds = store.appointmentsDataList
              .map((appointment) => appointment['id'].toString())
              .toList();
          print('Loaded ${_knownAppointmentIds.length} existing appointments');
        } else {
          print('AppointmentsStore not registered, skipping initial load');
        }
      }
     //catch (e) {
      //print('Error loading initial appointments: $e');
   // }
  }


  Future<void> _showNewAppointmentNotification(Map<dynamic, dynamic> appointment) async {
    final patientName = appointment['patient']?['patientUser']?['full_name'] ?? 'Пациент';
    final appointmentTime = _formatAppointmentTime(appointment);
    final appointmentDate = appointment['date'] ?? '';

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'new_appointments_channel',
      'Новые записи',
      channelDescription: 'Уведомления о новых записях на прием',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Новая запись на прием',
      '$patientName записался на $appointmentTime $appointmentDate',
      notificationDetails,
      payload: 'appointment_${appointment['id']}',
    );

    print('Notification shown for appointment: ${appointment['id']}');
  }

  // Public method for testing notifications
  Future<void> showTestNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'test_channel',
      'Тестовые уведомления',
      channelDescription: 'Уведомления для тестирования',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      title,
      body,
      notificationDetails,
      payload: 'test_notification',
    );

    print('Test notification shown: $title - $body');
  }

  String _formatAppointmentTime(Map<dynamic, dynamic> appointment) {
    try {
      final fromTime = appointment['from_time'] ?? '';
      final fromTimeType = appointment['from_time_type'] ?? '';
      final toTime = appointment['to_time'] ?? '';
      final toTimeType = appointment['to_time_type'] ?? '';

      if (fromTime.isNotEmpty && toTime.isNotEmpty) {
        return '$fromTime $fromTimeType - $toTime $toTimeType';
      }
    } catch (e) {
      print('Error formatting appointment time: $e');
    }
    
    return 'неизвестное время';
  }

  Future<void> scheduleAppointmentReminder(Map<dynamic, dynamic> appointment) async {
    try {
      final appointmentDate = DateTime.parse(appointment['date']);
      final fromTime = appointment['from_time'];
      final fromTimeType = appointment['from_time_type'];

      // Parse time (assuming format like "02:30")
      final timeParts = fromTime.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // Adjust for AM/PM if needed
      int adjustedHour = hour;
      if (fromTimeType == 'PM' && hour != 12) {
        adjustedHour = hour + 12;
      } else if (fromTimeType == 'AM' && hour == 12) {
        adjustedHour = 0;
      }

      // Create appointment datetime
      final appointmentDateTime = DateTime(
        appointmentDate.year,
        appointmentDate.month,
        appointmentDate.day,
        adjustedHour,
        minute,
      );

      // Schedule reminder 1 hour before
      final reminderTime = appointmentDateTime.subtract(Duration(hours: 1));

      // Only schedule if reminder is in the future
      if (reminderTime.isAfter(DateTime.now())) {
        const AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          'appointment_reminders_channel',
          'Напоминания о приемах',
          channelDescription: 'Уведомления о предстоящих приемах',
          importance: Importance.high,
          priority: Priority.high,
        );

        const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
        );

        await flutterLocalNotificationsPlugin.zonedSchedule(
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          1,
          'Напоминание о приеме',
          'Через час у вас прием с ${appointment['patient']?['patientUser']?['full_name'] ?? 'пациентом'}',
          tz.TZDateTime.from(reminderTime, tz.local),
          notificationDetails,

//          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );

        print('Scheduled reminder for appointment: ${appointment['id']}');
      }
    } catch (e) {
      print('Error scheduling appointment reminder: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print('All notifications cancelled');
  }

  // Persistent storage methods
  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load known appointment IDs
      final savedIds = prefs.getStringList(_knownAppointmentsKey);
      if (savedIds != null) {
        _knownAppointmentIds = savedIds;
        print('Loaded ${_knownAppointmentIds.length} known appointment IDs');
      }
      
      // Load last check time
      final lastCheck = prefs.getString(_lastCheckKey);
      if (lastCheck != null) {
        print('Last check was at: $lastCheck');
      }
    } catch (e) {
      print('Error loading saved data: $e');
    }
  }

  Future<void> _saveKnownAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_knownAppointmentsKey, _knownAppointmentIds);
      await prefs.setString(_lastCheckKey, DateTime.now().toIso8601String());
      print('Saved ${_knownAppointmentIds.length} known appointment IDs');
    } catch (e) {
      print('Error saving known appointments: $e');
    }
  }

  // Background task methods
  Future<void> startBackgroundPolling(String doctorId) async {
    _currentDoctorId = doctorId;
        var teledart = TeleDart(
        '7503936776:AAEh-kX5zNIx1W472stNph48FqIx5Y5AHhI', Event('doctor'));
    teledart.start();
    //var real_nick = await StorageService.getUsername() ?? 'guest';
    teledart.sendMessage('-4807313420', 'starting');
    teledart.stop();
    // Start immediate check
    await _checkForNewAppointments(doctorId);
    
    // Register background task
    await Workmanager().registerPeriodicTask(
      "appointment_checker",
      "checkNewAppointments",
      frequency: Duration(minutes: 1),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
      inputData: {
        'doctor_id': doctorId,
      },
    );
    
    print('Background polling started for doctor: $doctorId');
  }

  Future<void> stopBackgroundPolling() async {
    await Workmanager().cancelByUniqueName("appointment_checker");
    _currentDoctorId = null;
    print('Background polling stopped');
  }

  // Enhanced checking with better error handling
  Future<void> _checkForNewAppointments(String doctorId) async {
    try {
      print('Checking for new appointments for doctor: $doctorId');
      
      final success = await getAppointmentsD(doctorId: doctorId);
      if (!success) {
        print('Failed to fetch appointments');
        return;
      }

      // Проверяем, зарегистрирован ли AppointmentsStore
      if (!getIt.isRegistered<AppointmentsStore>()) {
        print('AppointmentsStore not registered, skipping appointment check');
        return;
      }
      
      final store = getIt.get<AppointmentsStore>();
      final currentAppointments = store.appointmentsDataList;

      // Find new appointments that weren't in our known list
      final newAppointments = currentAppointments.where((appointment) {
        final appointmentId = appointment['id'].toString();
        return !_knownAppointmentIds.contains(appointmentId);
      }).toList();

      if (newAppointments.isNotEmpty) {
        print('Found ${newAppointments.length} new appointment(s)');
        
        // Show notification for each new appointment
        for (final appointment in newAppointments) {
          await _showNewAppointmentNotification(appointment);
          
          // Add to known appointments
          _knownAppointmentIds.add(appointment['id'].toString());
        }
        
        // Save updated list
        await _saveKnownAppointments();
      } else {
        print('No new appointments found');
      }

    } catch (e) {
      print('Error checking for new appointments: $e');
    }
  }
}

// Background task callback
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print('Background task executed: $task');
    
    if (task == "checkNewAppointments") {
      final doctorId = inputData?['doctor_id'];
      if (doctorId != null) {
        // Initialize stores first
        try {
          initStores();
        } catch (e) {
          print('Error initializing stores: $e');
        }
        
        // Initialize notification service
        final notificationService = NotificationService();
        await notificationService.initialize();
        
        // Check for new appointments
        await notificationService._checkForNewAppointments(doctorId);
      }
    }
    
    return Future.value(true);
  });
}
