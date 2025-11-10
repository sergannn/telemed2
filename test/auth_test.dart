import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Authentication Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      // Очищаем данные перед каждым тестом
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    test('Should initialize session successfully', () async {
      await Session.init();
      expect(Session.data, isNotNull);
    });

    test('Should save and retrieve user from session', () async {
      final testUser = UserModel(
        userId: '1',
        patientId: '1',
        doctorId: null,
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        authToken: 'test_token_123',
        gender: '1',
      );

      await Session().saveUser(testUser);
      final retrievedUser = await Session.getCurrentUser();

      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.userId, '1');
      expect(retrievedUser?.userName, 'testuser');
      expect(retrievedUser?.email, 'test@example.com');
      expect(retrievedUser?.firstName, 'Test');
      expect(retrievedUser?.lastName, 'User');
      expect(retrievedUser?.authToken, 'test_token_123');
      expect(retrievedUser?.gender, '1');
    });

    test('Should return null when user is not logged in', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();

      final user = await Session.getCurrentUser();
      expect(user, isNull);
    });

    test('Should update user field successfully', () async {
      final testUser = UserModel(
        userId: '1',
        patientId: '1',
        userName: 'testuser',
        firstName: 'Original',
        lastName: 'Name',
        email: 'original@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      final updatedUser = await Session().updateUserField(
        testUser,
        fieldName: 'first_name',
        newValue: 'Updated',
      );

      expect(updatedUser.firstName, 'Updated');

      final savedUser = await Session.getCurrentUser();
      expect(savedUser?.firstName, 'Updated');
    });

    test('Should update multiple user fields', () async {
      final testUser = UserModel(
        userId: '1',
        patientId: '1',
        userName: 'testuser',
        firstName: 'First',
        lastName: 'Last',
        email: 'email@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      await Session().updateUserField(testUser, fieldName: 'first_name', newValue: 'NewFirst');
      await Session().updateUserField(testUser, fieldName: 'last_name', newValue: 'NewLast');
      await Session().updateUserField(testUser, fieldName: 'email', newValue: 'newemail@example.com');

      final savedUser = await Session.getCurrentUser();
      expect(savedUser?.firstName, 'NewFirst');
      expect(savedUser?.lastName, 'NewLast');
      expect(savedUser?.email, 'newemail@example.com');
    });

    test('Should handle doctor user with doctor_id', () async {
      final doctorUser = UserModel(
        userId: '2',
        patientId: null,
        doctorId: 'doc_1',
        userName: 'doctor',
        firstName: 'Doctor',
        lastName: 'Name',
        email: 'doctor@example.com',
        authToken: 'doctor_token',
        gender: '1',
      );

      await Session().saveUser(doctorUser);
      final retrievedUser = await Session.getCurrentUser();

      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.doctorId, 'doc_1');
      expect(retrievedUser?.patientId, isNull);
    });

    test('Should handle patient user with patient_id', () async {
      final patientUser = UserModel(
        userId: '3',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'patient',
        firstName: 'Patient',
        lastName: 'Name',
        email: 'patient@example.com',
        authToken: 'patient_token',
        gender: '2',
      );

      await Session().saveUser(patientUser);
      final retrievedUser = await Session.getCurrentUser();

      expect(retrievedUser, isNotNull);
      expect(retrievedUser?.patientId, 'pat_1');
      expect(retrievedUser?.doctorId, isNull);
    });

    test('Should throw exception when updating invalid field', () async {
      final testUser = UserModel(
        userId: '1',
        patientId: '1',
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      expect(
        () => Session().updateUserField(testUser, fieldName: 'invalid_field', newValue: 'value'),
        throwsException,
      );
    });

    test('Should update gender field', () async {
      final testUser = UserModel(
        userId: '1',
        patientId: '1',
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      final updatedUser = await Session().updateUserField(
        testUser,
        fieldName: 'gender',
        newValue: '2',
      );

      expect(updatedUser.gender, '2');

      final savedUser = await Session.getCurrentUser();
      expect(savedUser?.gender, '2');
    });
  });
}

