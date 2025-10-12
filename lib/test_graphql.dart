import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GraphQLTester {
  static const String baseUrl = 'https://admin.onlinedoctor.su';
  static const String graphqlEndpoint = '$baseUrl/graphql';

  // Тест получения appointments для доктора
  static Future<void> testGetAppointments(String doctorId) async {
    print('=== Тест получения appointments для доктора $doctorId ===\n');

    final query = '''
      query appointments {
        appointmentsbydoctor(doctor_id: "$doctorId") {
          id
          date
          appointment_unique_id
          patient {
            patientUser {
              id
              full_name 
              first_name
              profile_image
            }
          }
          doctor {
            doctor_id: id
            specializations {
              name
            }
            doctorUser {
              user_id: id 
              username: full_name
              first_name
              last_name
              photo: profile_image
            }
          }
          description
          status
          from_time
          from_time_type
          to_time
          to_time_type
          room_data
        }
      }
    ''';

    try {
      final response = await http.post(
        Uri.parse(graphqlEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'query': query,
        }),
      );

      print('Статус ответа: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['errors'] != null) {
          print('❌ GraphQL ошибки:');
          for (var error in data['errors']) {
            print('  - ${error['message']}');
          }
          return;
        }

        final appointments = data['data']['appointmentsbydoctor'] as List;
        print('✅ Найдено ${appointments.length} записей\n');

        for (var appointment in appointments) {
          print('📅 Запись #${appointment['id']}');
          print('   Уникальный ID: ${appointment['appointment_unique_id']}');
          print('   Дата: ${appointment['date']}');
          print('   Время: ${appointment['from_time']} ${appointment['from_time_type']} - ${appointment['to_time']} ${appointment['to_time_type']}');
          print('   Статус: ${appointment['status']}');
          print('   Пациент: ${appointment['patient']?['patientUser']?['full_name'] ?? 'Неизвестно'}');
          print('   Описание: ${appointment['description'] ?? 'Нет описания'}');
          print('');
        }
      } else {
        print('❌ HTTP ошибка: ${response.statusCode}');
        print('Ответ: ${response.body}');
      }
    } catch (e) {
      print('❌ Ошибка запроса: $e');
    }
  }

  // Тест создания новой записи через GraphQL
  static Future<void> testCreateAppointment(String doctorId, String patientId) async {
    print('=== Тест создания записи через GraphQL ===\n');

    final tomorrow = DateTime.now().add(Duration(days: 1));
    final dateStr = '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
    
    final mutation = '''
      mutation {
        createAppointment(
          doctor_id: "$doctorId"
          patient_id: "$patientId"
          date: "$dateStr"
          from_time: "15:00"
          from_time_type: "PM"
          to_time: "16:00"
          to_time_type: "PM"
          status: "1"
          description: "Тестовая запись через GraphQL - ${DateTime.now()}"
          service_id: "1"
          payment_type: "2"
          payable_amount: "1500.00"
        ) {
          id
          appointment_unique_id
          date
          from_time
          to_time
          status
        }
      }
    ''';

    try {
      final response = await http.post(
        Uri.parse(graphqlEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'query': mutation,
        }),
      );

      print('Статус ответа: ${response.statusCode}');
      print('Ответ: ${response.body}\n');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['errors'] != null) {
          print('❌ GraphQL ошибки:');
          for (var error in data['errors']) {
            print('  - ${error['message']}');
          }
        } else if (data['data']?['createAppointment'] != null) {
          final appointment = data['data']['createAppointment'];
          print('✅ Запись успешно создана!');
          print('   ID: ${appointment['id']}');
          print('   Уникальный ID: ${appointment['appointment_unique_id']}');
          print('   Дата: ${appointment['date']}');
          print('   Время: ${appointment['from_time']} - ${appointment['to_time']}');
          print('   Статус: ${appointment['status']}');
        }
      } else {
        print('❌ HTTP ошибка: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Ошибка запроса: $e');
    }
  }

  // Тест получения докторов
  static Future<void> testGetDoctors() async {
    print('=== Тест получения списка докторов ===\n');

    final query = '''
      query doctors {
        doctors(first: 5) {
          data {
            doctor_id: id
            specializations {
              name
            }
            doctorUser {
              user_id: id 
              username: full_name
              first_name
              last_name
              photo: profile_image
            }
          }
        }
      }
    ''';

    try {
      final response = await http.post(
        Uri.parse(graphqlEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['errors'] != null) {
          print('❌ GraphQL ошибки:');
          for (var error in data['errors']) {
            print('  - ${error['message']}');
          }
          return;
        }

        final doctors = data['data']['doctors']['data'] as List;
        print('✅ Найдено ${doctors.length} докторов\n');

        for (var doctor in doctors) {
          print('👨‍⚕️ Доктор #${doctor['doctor_id']}');
          print('   Имя: ${doctor['doctorUser']?['username'] ?? 'Неизвестно'}');
          print('   Специализация: ${doctor['specializations']?[0]?['name'] ?? 'Не указана'}');
          print('');
        }
      } else {
        print('❌ HTTP ошибка: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Ошибка запроса: $e');
    }
  }
}

void main() async {
  print('🚀 Запуск тестов GraphQL API\n');
  
  // 1. Получить список докторов
  await GraphQLTester.testGetDoctors();
  
  // 2. Тест с первым доктором (замените на реальный ID)
  const testDoctorId = '1'; // Замените на реальный ID доктора
  await GraphQLTester.testGetAppointments(testDoctorId);
  
  // 3. Создать тестовую запись (замените на реальные ID)
  const testPatientId = '1'; // Замените на реальный ID пациента
  await GraphQLTester.testCreateAppointment(testDoctorId, testPatientId);
  
  // 4. Проверить appointments после создания
  print('\n=== Проверка после создания записи ===');
  await GraphQLTester.testGetAppointments(testDoctorId);
  
  print('\n✅ Тесты завершены!');
}


