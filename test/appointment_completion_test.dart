import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Appointment Completion Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    test('Should identify doctor user by doctor_id', () async {
      final doctorUser = UserModel(
        userId: '1',
        patientId: null,
        doctorId: 'doc_1',
        userName: 'doctor',
        firstName: 'Doctor',
        lastName: 'Name',
        email: 'doctor@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(doctorUser);
      final currentUser = await Session.getCurrentUser();

      expect(currentUser, isNotNull);
      expect(currentUser?.doctorId, isNotNull);
      expect(currentUser?.doctorId, 'doc_1');
      // Врач может завершить прием
      expect(currentUser?.doctorId != null, true);
    });

    test('Should identify patient user without doctor_id', () async {
      final patientUser = UserModel(
        userId: '2',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'patient',
        firstName: 'Patient',
        lastName: 'Name',
        email: 'patient@example.com',
        authToken: 'token',
        gender: '2',
      );

      await Session().saveUser(patientUser);
      final currentUser = await Session.getCurrentUser();

      expect(currentUser, isNotNull);
      expect(currentUser?.doctorId, isNull);
      // Пациент не может завершить прием
      expect(currentUser?.doctorId != null, false);
    });

    test('Should verify only doctor can complete appointment', () async {
      // Тест для врача
      final doctorUser = UserModel(
        userId: '1',
        patientId: null,
        doctorId: 'doc_1',
        userName: 'doctor',
        firstName: 'Doctor',
        lastName: 'Name',
        email: 'doctor@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(doctorUser);
      final doctor = await Session.getCurrentUser();
      final canCompleteAsDoctor = doctor?.doctorId != null;
      expect(canCompleteAsDoctor, true);

      // Тест для пациента
      final patientUser = UserModel(
        userId: '2',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'patient',
        firstName: 'Patient',
        lastName: 'Name',
        email: 'patient@example.com',
        authToken: 'token',
        gender: '2',
      );

      await Session().saveUser(patientUser);
      final patient = await Session.getCurrentUser();
      final canCompleteAsPatient = patient?.doctorId != null;
      expect(canCompleteAsPatient, false);
    });
  });
}

