import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NotificationTester {
  static const String baseUrl = 'https://admin.onlinedoctor.su';
  static const String graphqlEndpoint = '$baseUrl/graphql';

  // Создать тестовую запись и проверить уведомления
  static Future<void> createTestAppointmentAndCheckNotifications() async {
    print('🧪 === Тест создания записи и проверки уведомлений ===\n');

    try {
      // 1. Получить список докторов
      print('1️⃣ Получение списка докторов...');
      final doctors = await _getDoctors();
      if (doctors.isEmpty) {
        print('❌ Не найдено докторов');
        return;
      }

      final doctor = doctors.first;
      final doctorId = doctor['doctor_id'].toString();
      print('✅ Выбран доктор: ${doctor['doctorUser']?['username']} (ID: $doctorId)');

      // 2. Получить список пациентов
      print('\n2️⃣ Получение списка пациентов...');
      final patients = await _getPatients();
      if (patients.isEmpty) {
        print('❌ Не найдено пациентов');
        return;
      }

      final patient = patients.first;
      final patientId = patient['id'].toString();
      print('✅ Выбран пациент: ${patient['full_name']} (ID: $patientId)');

      // 3. Получить текущие записи доктора
      print('\n3️⃣ Получение текущих записей доктора...');
      final currentAppointments = await _getAppointmentsForDoctor(doctorId);
      print('📅 Текущее количество записей: ${currentAppointments.length}');

      // 4. Создать новую тестовую запись
      print('\n4️⃣ Создание новой тестовой записи...');
      final newAppointment = await _createTestAppointment(doctorId, patientId);
      if (newAppointment == null) {
        print('❌ Не удалось создать запись');
        return;
      }

      print('✅ Создана новая запись:');
      print('   ID: ${newAppointment['id']}');
      print('   Уникальный ID: ${newAppointment['appointment_unique_id']}');
      print('   Дата: ${newAppointment['date']}');
      print('   Время: ${newAppointment['from_time']} ${newAppointment['from_time_type']}');

      // 5. Проверить записи после создания
      print('\n5️⃣ Проверка записей после создания...');
      final updatedAppointments = await _getAppointmentsForDoctor(doctorId);
      print('📅 Новое количество записей: ${updatedAppointments.length}');

      // 6. Найти новую запись
      final newAppointmentId = newAppointment['id'].toString();
      final foundNewAppointment = updatedAppointments.firstWhere(
        (apt) => apt['id'].toString() == newAppointmentId,
        orElse: () => null,
      );

      if (foundNewAppointment != null) {
        print('✅ Новая запись найдена в списке appointments!');
        print('   Это означает, что система уведомлений должна сработать при следующей проверке.');
      } else {
        print('❌ Новая запись не найдена в списке appointments');
      }

      // 7. Инструкции для тестирования
      print('\n📱 === Инструкции для тестирования уведомлений ===');
      print('1. Запустите Flutter приложение доктора');
      print('2. Перейдите на экран /test_notifications');
      print('3. Нажмите "Запустить Polling"');
      print('4. Подождите 1-2 минуты');
      print('5. Должно прийти уведомление о новой записи');
      print('\nИли создайте еще одну запись через этот скрипт:');
      print('   dart test_notifications.dart --create-more');

    } catch (e) {
      print('❌ Ошибка: $e');
    }
  }

  // Получить список докторов
  static Future<List<dynamic>> _getDoctors() async {
    final query = '''
      query doctors {
        doctors(first: 5) {
          data {
            doctor_id: id
            doctorUser {
              user_id: id 
              username: full_name
              first_name
              last_name
            }
          }
        }
      }
    ''';

    final response = await _makeGraphQLRequest(query);
    if (response != null && response['data']?['doctors']?['data'] != null) {
      return response['data']['doctors']['data'] as List<dynamic>;
    }
    return [];
  }

  // Получить список пациентов
  static Future<List<dynamic>> _getPatients() async {
    final query = '''
      query patients {
        patients(first: 5) {
          data {
            id
            patientUser {
              full_name
              first_name
            }
          }
        }
      }
    ''';

    final response = await _makeGraphQLRequest(query);
    if (response != null && response['data']?['patients']?['data'] != null) {
      return response['data']['patients']['data'] as List<dynamic>;
    }
    return [];
  }

  // Получить записи для доктора
  static Future<List<dynamic>> _getAppointmentsForDoctor(String doctorId) async {
    final query = '''
      query appointments {
        appointmentsbydoctor(doctor_id: "$doctorId") {
          id
          date
          appointment_unique_id
          patient {
            patientUser {
              full_name
            }
          }
          status
          from_time
          from_time_type
          to_time
          to_time_type
        }
      }
    ''';

    final response = await _makeGraphQLRequest(query);
    if (response != null && response['data']?['appointmentsbydoctor'] != null) {
      return response['data']['appointmentsbydoctor'] as List<dynamic>;
    }
    return [];
  }

  // Создать тестовую запись
  static Future<Map<String, dynamic>?> _createTestAppointment(String doctorId, String patientId) async {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    final dateStr = '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
    
    final mutation = '''
      mutation {
        createAppointment(
          doctor_id: "$doctorId"
          patient_id: "$patientId"
          date: "$dateStr"
          from_time: "16:00"
          from_time_type: "PM"
          to_time: "17:00"
          to_time_type: "PM"
          status: "1"
          description: "Тестовая запись для уведомлений - ${DateTime.now()}"
          service_id: "1"
          payment_type: "2"
          payable_amount: "2000.00"
        ) {
          id
          appointment_unique_id
          date
          from_time
          from_time_type
          to_time
          to_time_type
          status
        }
      }
    ''';

    final response = await _makeGraphQLRequest(mutation);
    if (response != null && response['data']?['createAppointment'] != null) {
      return response['data']['createAppointment'] as Map<String, dynamic>;
    }
    return null;
  }

  // Выполнить GraphQL запрос
  static Future<Map<String, dynamic>?> _makeGraphQLRequest(String query) async {
    try {
      final response = await http.post(
        Uri.parse(graphqlEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['errors'] != null) {
          print('❌ GraphQL ошибки:');
          for (var error in data['errors']) {
            print('  - ${error['message']}');
          }
          return null;
        }
        
        return data;
      } else {
        print('❌ HTTP ошибка: ${response.statusCode}');
        print('Ответ: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Ошибка запроса: $e');
      return null;
    }
  }

  // Создать несколько тестовых записей
  static Future<void> createMultipleTestAppointments() async {
    print('🧪 === Создание нескольких тестовых записей ===\n');

    try {
      final doctors = await _getDoctors();
      final patients = await _getPatients();
      
      if (doctors.isEmpty || patients.isEmpty) {
        print('❌ Не найдено докторов или пациентов');
        return;
      }

      final doctorId = doctors.first['doctor_id'].toString();
      final patientId = patients.first['id'].toString();

      print('Создание 3 тестовых записей...\n');

      for (int i = 1; i <= 3; i++) {
        print('📝 Создание записи #$i...');
        
        final tomorrow = DateTime.now().add(Duration(days: i));
        final dateStr = '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
        
        final mutation = '''
          mutation {
            createAppointment(
              doctor_id: "$doctorId"
              patient_id: "$patientId"
              date: "$dateStr"
              from_time: "${14 + i}:00"
              from_time_type: "PM"
              to_time: "${15 + i}:00"
              to_time_type: "PM"
              status: "1"
              description: "Тестовая запись #$i - ${DateTime.now()}"
              service_id: "1"
              payment_type: "2"
              payable_amount: "${(1000 + i * 500).toStringAsFixed(2)}"
            ) {
              id
              appointment_unique_id
              date
              from_time
              to_time
            }
          }
        ''';

        final response = await _makeGraphQLRequest(mutation);
        if (response != null && response['data']?['createAppointment'] != null) {
          final appointment = response['data']['createAppointment'];
          print('✅ Запись #$i создана: ID ${appointment['id']}, дата ${appointment['date']}');
        } else {
          print('❌ Не удалось создать запись #$i');
        }
        
        // Небольшая пауза между запросами
        await Future.delayed(Duration(seconds: 1));
      }

      print('\n🎉 Создание тестовых записей завершено!');
      print('Теперь запустите Flutter приложение и проверьте уведомления.');

    } catch (e) {
      print('❌ Ошибка: $e');
    }
  }
}

void main(List<String> args) async {
  print('🚀 Запуск тестов уведомлений\n');
  
  if (args.contains('--create-more')) {
    await NotificationTester.createMultipleTestAppointments();
  } else {
    await NotificationTester.createTestAppointmentAndCheckNotifications();
  }
}


