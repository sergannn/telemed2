import 'package:doctorq/services/notification_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:get_it/get_it.dart';
import 'package:doctorq/utils/utility.dart';

class NotificationManager {
  static final NotificationManager _instance = NotificationManager._internal();
  factory NotificationManager() => _instance;
  NotificationManager._internal();

  final NotificationService _notificationService = NotificationService();
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      printLog('Initializing NotificationManager...');
      
      // Initialize notification service
      await _notificationService.initialize();
      
      _isInitialized = true;
      printLog('NotificationManager initialized successfully');
    } catch (e) {
      printLog('Error initializing NotificationManager: $e');
    }
  }

  Future<void> startPollingForCurrentDoctor() async {
    try {
      // Get current user
      final currentUser = await Session.getCurrentUser();
      if (currentUser == null) {
        printLog('No current user found, cannot start polling');
        return;
      }

      // Get doctor ID from user data
      final doctorId = currentUser.userId;
      if (doctorId == null || doctorId.isEmpty) {
        printLog('No doctor ID found for current user');
        return;
      }

      printLog('Starting notification polling for doctor: $doctorId');
      
      // Start background polling
      await _notificationService.startBackgroundPolling(doctorId);
      
      printLog('Notification polling started successfully');
    } catch (e) {
      printLog('Error starting notification polling: $e');
    }
  }

  Future<void> stopPolling() async {
    try {
      printLog('Stopping notification polling...');
      await _notificationService.stopBackgroundPolling();
      printLog('Notification polling stopped');
    } catch (e) {
      printLog('Error stopping notification polling: $e');
    }
  }

  Future<void> showTestNotification() async {
    try {
      await _notificationService.showTestNotification(
        'Тестовое уведомление',
        'Это тестовое уведомление для проверки работы системы'
      );
    } catch (e) {
      printLog('Error showing test notification: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _notificationService.cancelAllNotifications();
      printLog('All notifications cancelled');
    } catch (e) {
      printLog('Error cancelling notifications: $e');
    }
  }

  // Method to check if polling is active
  bool isPollingActive() {
    return _isInitialized;
  }
}


