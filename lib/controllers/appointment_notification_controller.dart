import 'dart:async';
import 'package:get/get.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/notification_service.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

class AppointmentNotificationController extends GetxController {
  static const String _knownAppointmentsKey = 'known_appointment_ids_doctor';
  
  Timer? _checkTimer;
  final RxList<String> knownAppointmentIds = <String>[].obs;
  final RxString currentDoctorId = ''.obs;
  final RxBool isChecking = false.obs;
  final RxInt lastCheckCount = 0.obs;
  
  NotificationService get _notificationService => getIt.get<NotificationService>();
  
  @override
  void onInit() {
    super.onInit();
    _loadKnownAppointments();
  }
  
  @override
  void onClose() {
    stopChecking();
    super.onClose();
  }
  
  /// Загрузить известные ID записей из SharedPreferences
  Future<void> _loadKnownAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedIds = prefs.getStringList(_knownAppointmentsKey);
      if (savedIds != null) {
        knownAppointmentIds.value = savedIds;
        print('Загружено ${knownAppointmentIds.length} известных ID записей');
      }
    } catch (e) {
      print('Ошибка загрузки известных записей: $e');
    }
  }
  
  /// Сохранить известные ID записей в SharedPreferences
  Future<void> _saveKnownAppointments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_knownAppointmentsKey, knownAppointmentIds.toList());
      print('Сохранено ${knownAppointmentIds.length} известных ID записей');
    } catch (e) {
      print('Ошибка сохранения известных записей: $e');
    }
  }
  
  /// Начать проверку новых записей раз в минуту
  Future<void> startChecking(String doctorId) async {
    if (currentDoctorId.value == doctorId && _checkTimer != null && _checkTimer!.isActive) {
      print('Проверка уже запущена для врача: $doctorId');
      return;
    }
    
    // Остановить предыдущую проверку, если была
    stopChecking();
    
    // Убедиться, что NotificationService инициализирован
    try {
      await _notificationService.initialize();
    } catch (e) {
      print('NotificationService уже инициализирован или ошибка: $e');
    }
    
    currentDoctorId.value = doctorId;
    
    // Загрузить начальные записи
    await _loadInitialAppointments(doctorId);
    
    // Начать периодическую проверку раз в минуту
    _checkTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _checkForNewAppointments(doctorId),
    );
    
    // Сразу проверить один раз
    await _checkForNewAppointments(doctorId);
    
    print('Запущена проверка новых записей для врача: $doctorId');
  }
  
  /// Остановить проверку
  void stopChecking() {
    _checkTimer?.cancel();
    _checkTimer = null;
    currentDoctorId.value = '';
    isChecking.value = false;
    print('Проверка новых записей остановлена');
  }
  
  /// Загрузить начальные записи для определения базовой линии
  Future<void> _loadInitialAppointments(String doctorId) async {
    try {
      final success = await getAppointmentsD(doctorId: doctorId);
      if (success && getIt.isRegistered<AppointmentsStore>()) {
        final store = getIt.get<AppointmentsStore>();
        knownAppointmentIds.value = store.appointmentsDataList
            .map((appointment) => appointment['id'].toString())
            .toList();
        await _saveKnownAppointments();
        print('Загружено ${knownAppointmentIds.length} начальных записей');
      }
    } catch (e) {
      print('Ошибка загрузки начальных записей: $e');
    }
  }
  
  /// Проверить наличие новых записей
  Future<void> _checkForNewAppointments(String doctorId) async {
    if (isChecking.value) {
      print('Проверка уже выполняется, пропускаем');
      return;
    }
    
    isChecking.value = true;
    
    try {
      print('Проверка новых записей для врача: $doctorId');
      
      final success = await getAppointmentsD(doctorId: doctorId);
      if (!success) {
        print('Не удалось получить записи');
        return;
      }
      
      if (!getIt.isRegistered<AppointmentsStore>()) {
        print('AppointmentsStore не зарегистрирован');
        return;
      }
      
      final store = getIt.get<AppointmentsStore>();
      final currentAppointments = store.appointmentsDataList;
      
      // Найти новые записи
      final newAppointments = currentAppointments.where((appointment) {
        final appointmentId = appointment['id'].toString();
        return !knownAppointmentIds.contains(appointmentId);
      }).toList();
      
      if (newAppointments.isNotEmpty) {
        print('Найдено ${newAppointments.length} новых записей');
        lastCheckCount.value = newAppointments.length;
        
        // Показать уведомление для каждой новой записи
        for (final appointment in newAppointments) {
          await _showNewAppointmentNotification(appointment);
          
          // Добавить в известные
          knownAppointmentIds.add(appointment['id'].toString());
        }
        
        // Сохранить обновленный список
        await _saveKnownAppointments();
        
        // Обновить UI если нужно
        update();
      } else {
        print('Новых записей не найдено');
        lastCheckCount.value = 0;
      }
      
    } catch (e) {
      print('Ошибка при проверке новых записей: $e');
    } finally {
      isChecking.value = false;
    }
  }
  
  /// Показать уведомление о новой записи
  Future<void> _showNewAppointmentNotification(Map<dynamic, dynamic> appointment) async {
    try {
      final patientName = appointment['patient']?['patientUser']?['full_name'] ?? 
                         appointment['patient']?['patientUser']?['first_name'] ?? 
                         'Пациент';
      final appointmentTime = _formatAppointmentTime(appointment);
      final appointmentDate = appointment['date'] ?? '';
      
      await _notificationService.showTestNotification(
        'Новая запись на прием',
        '$patientName записался на $appointmentTime $appointmentDate',
      );
      
      print('Уведомление показано для записи: ${appointment['id']}');
    } catch (e) {
      print('Ошибка показа уведомления: $e');
    }
  }
  
  /// Форматировать время записи
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
      print('Ошибка форматирования времени: $e');
    }
    
    return 'неизвестное время';
  }
  
  /// Принудительная проверка (для тестирования)
  Future<void> checkNow() async {
    if (currentDoctorId.value.isNotEmpty) {
      await _checkForNewAppointments(currentDoctorId.value);
    }
  }
}

