import 'dart:math';
import 'package:doctorq/models/appointment_model.dart';
import 'package:doctorq/models/doctor_session_model.dart';
import 'package:doctorq/models/doctor_model.dart';
import 'package:doctorq/models/patient_model.dart';

class FakeDataService {
  static final Random _random = Random();

  // Генерация фейковых сеансов для врача
  static List<Map<String, dynamic>> generateFakeDoctorSessions(String doctorId) {
    List<Map<String, dynamic>> sessions = [];
    
    // Создаем 3-5 фейковых сеансов
    int sessionCount = 3 + _random.nextInt(3);
    
    for (int i = 0; i < sessionCount; i++) {
      sessions.add({
        'id': 'session_${doctorId}_${i + 1}',
        'doctor_id': doctorId,
        'session_meeting_time': 30 + _random.nextInt(30), // 30-60 минут
        'session_gap': '15',
        'doctor': {
          'doctor_id': doctorId,
          'doctorUser': {
            'user_id': doctorId,
            'username': 'Доктор Иванов',
            'first_name': 'Иван',
            'last_name': 'Иванов',
            'photo': 'https://via.placeholder.com/100'
          }
        },
        'sessionWeekDays': _generateSessionWeekDays()
      });
    }
    
    return sessions;
  }

  // Генерация фейковых записей (appointments) для врача и пациента
  static List<Map<String, dynamic>> generateFakeAppointments(String userId, String userType) {
    List<Map<String, dynamic>> appointments = [];
    
    // Создаем 4-8 фейковых записей
    int appointmentCount = 4 + _random.nextInt(5);
    
    for (int i = 0; i < appointmentCount; i++) {
      bool isUpcoming = _random.nextBool();
      DateTime appointmentDate;
      
      if (isUpcoming) {
        // Предстоящие записи (от завтра до 2 недель)
        appointmentDate = DateTime.now().add(Duration(days: 1 + _random.nextInt(14)));
      } else {
        // Прошедшие записи (от 1 недели назад до вчера)
        appointmentDate = DateTime.now().subtract(Duration(days: 1 + _random.nextInt(7)));
      }
      
      String timeSlot = _generateTimeSlot();
      List<String> timeParts = timeSlot.split(' - ');
      
      appointments.add({
        'id': 'appointment_${userId}_${i + 1}',
        'patient_id': userType == 'patient' ? userId : _generatePatientId(),
        'doctor_id': userType == 'doctor' ? userId : _generateDoctorId(),
        'date': appointmentDate.toIso8601String().split('T')[0],
        'from_time': timeParts[0],
        'to_time': timeParts[1],
        'from_time_type': 'AM',
        'to_time_type': 'AM',
        'status': isUpcoming ? 'BOOKED' : 'CHECK_OUT',
        'appointment_type': _random.nextBool() ? 'VIDEO' : 'AUDIO',
        'patient': userType == 'patient' ? null : _generateFakePatient(),
        'doctor': userType == 'doctor' ? null : _generateFakeDoctor(),
        'created_at': DateTime.now().subtract(Duration(days: _random.nextInt(30))).toIso8601String(),
        'updated_at': DateTime.now().subtract(Duration(days: _random.nextInt(7))).toIso8601String()
      });
    }
    
    return appointments;
  }

  // Генерация предстоящих сеансов для главной страницы
  static List<Map<String, dynamic>> generateUpcomingSessionsForHome(String userId, String userType) {
    List<Map<String, dynamic>> upcomingSessions = [];
    
    // Создаем 2-4 предстоящих сеанса на ближайшие дни
    int sessionCount = 2 + _random.nextInt(3);
    
    for (int i = 0; i < sessionCount; i++) {
      DateTime sessionDate = DateTime.now().add(Duration(days: 1 + i));
      String timeSlot = _generateTimeSlot();
      List<String> timeParts = timeSlot.split(' - ');
      
      upcomingSessions.add({
        'id': 'upcoming_session_${userId}_${i + 1}',
        'patient_id': userType == 'patient' ? userId : _generatePatientId(),
        'doctor_id': userType == 'doctor' ? userId : _generateDoctorId(),
        'date': sessionDate.toIso8601String().split('T')[0],
        'from_time': timeParts[0],
        'to_time': timeParts[1],
        'from_time_type': 'AM',
        'to_time_type': 'AM',
        'status': 'BOOKED',
        'appointment_type': _random.nextBool() ? 'VIDEO' : 'AUDIO',
        'patient': userType == 'patient' ? null : _generateFakePatient(),
        'doctor': userType == 'doctor' ? null : _generateFakeDoctor(),
        'description': _generateSessionDescription(),
        'created_at': DateTime.now().subtract(Duration(days: _random.nextInt(7))).toIso8601String(),
        'updated_at': DateTime.now().subtract(Duration(days: _random.nextInt(3))).toIso8601String()
      });
    }
    
    return upcomingSessions;
  }

  static List<Map<String, dynamic>> _generateSessionWeekDays() {
    List<Map<String, dynamic>> weekDays = [];
    List<String> days = ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница'];
    
    for (int i = 0; i < 5; i++) {
      if (_random.nextBool()) { // 50% вероятность что день рабочий
        weekDays.add({
          'day_of_week': i + 1,
          'start_time': '09:00',
          'start_time_type': 'AM',
          'end_time': '18:00',
          'end_time_type': 'PM'
        });
      }
    }
    
    return weekDays;
  }

  static String _generateTimeSlot() {
    List<String> timeSlots = [
      '09:00 - 09:30',
      '10:00 - 10:30',
      '11:00 - 11:30',
      '14:00 - 14:30',
      '15:00 - 15:30',
      '16:00 - 16:30',
      '17:00 - 17:30'
    ];
    
    return timeSlots[_random.nextInt(timeSlots.length)];
  }

  static String _generateSessionDescription() {
    List<String> descriptions = [
      'Консультация по результатам анализов',
      'Плановый осмотр',
      'Консультация по жалобам',
      'Повторный прием',
      'Консультация по лечению',
      'Профилактический осмотр'
    ];
    
    return descriptions[_random.nextInt(descriptions.length)];
  }

  static String _generatePatientId() {
    return 'patient_${1 + _random.nextInt(10)}';
  }

  static String _generateDoctorId() {
    return 'doctor_${1 + _random.nextInt(5)}';
  }

  static Map<String, dynamic> _generateFakePatient() {
    List<String> firstNames = ['Анна', 'Мария', 'Елена', 'Ольга', 'Татьяна', 'Ирина', 'Наталья', 'Светлана'];
    List<String> lastNames = ['Петрова', 'Иванова', 'Сидорова', 'Козлова', 'Морозова', 'Волкова', 'Соколова', 'Лебедева'];
    
    return {
      'patient_id': _generatePatientId(),
      'patientUser': {
        'user_id': _generatePatientId(),
        'username': '${firstNames[_random.nextInt(firstNames.length)]} ${lastNames[_random.nextInt(lastNames.length)]}',
        'first_name': firstNames[_random.nextInt(firstNames.length)],
        'last_name': lastNames[_random.nextInt(lastNames.length)],
        'photo': 'https://via.placeholder.com/100'
      }
    };
  }

  static Map<String, dynamic> _generateFakeDoctor() {
    List<String> firstNames = ['Александр', 'Дмитрий', 'Михаил', 'Сергей', 'Андрей', 'Владимир', 'Николай', 'Игорь'];
    List<String> lastNames = ['Петров', 'Иванов', 'Сидоров', 'Козлов', 'Морозов', 'Волков', 'Соколов', 'Лебедев'];
    List<String> specializations = ['Терапевт', 'Кардиолог', 'Невролог', 'Педиатр', 'Хирург', 'Офтальмолог'];
    
    return {
      'doctor_id': _generateDoctorId(),
      'doctorUser': {
        'user_id': _generateDoctorId(),
        'username': 'Доктор ${firstNames[_random.nextInt(firstNames.length)]} ${lastNames[_random.nextInt(lastNames.length)]}',
        'first_name': firstNames[_random.nextInt(firstNames.length)],
        'last_name': lastNames[_random.nextInt(lastNames.length)],
        'photo': 'https://via.placeholder.com/100'
      },
      'specialization': specializations[_random.nextInt(specializations.length)]
    };
  }
}
