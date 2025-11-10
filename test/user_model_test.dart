import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('Should create UserModel with all fields', () {
      final user = UserModel(
        userId: '1',
        patientId: 'pat_1',
        doctorId: 'doc_1',
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        photo: 'photo.jpg',
        authToken: 'token_123',
        gender: '1',
      );

      expect(user.userId, '1');
      expect(user.patientId, 'pat_1');
      expect(user.doctorId, 'doc_1');
      expect(user.userName, 'testuser');
      expect(user.firstName, 'Test');
      expect(user.lastName, 'User');
      expect(user.email, 'test@example.com');
      expect(user.photo, 'photo.jpg');
      expect(user.authToken, 'token_123');
      expect(user.gender, '1');
    });

    test('Should create UserModel from JSON', () {
      final json = {
        'token': 'test_token',
        'user': {
          'user_id': '1',
          'patient_id': 'pat_1',
          'doctor_id': 'doc_1',
          'username': 'testuser',
          'first_name': 'Test',
          'last_name': 'User',
          'email': 'test@example.com',
          'photo': 'photo.jpg',
          'gender': '2',
        }
      };

      final user = UserModel.fromJson(json);

      expect(user.userId, '1');
      expect(user.patientId, 'pat_1');
      expect(user.doctorId, 'doc_1');
      expect(user.userName, 'testuser');
      expect(user.firstName, 'Test');
      expect(user.lastName, 'User');
      expect(user.email, 'test@example.com');
      expect(user.photo, 'photo.jpg');
      expect(user.authToken, 'test_token');
      expect(user.gender, '2');
    });

    test('Should convert UserModel to JSON', () {
      final user = UserModel(
        userId: '1',
        patientId: 'pat_1',
        doctorId: 'doc_1',
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        photo: 'photo.jpg',
        authToken: 'token_123',
        gender: '1',
      );

      final json = user.toJson();

      expect(json['user_id'], '1');
      expect(json['patient_id'], 'pat_1');
      expect(json['doctor_id'], 'doc_1');
      expect(json['username'], 'testuser');
      expect(json['first_name'], 'Test');
      expect(json['last_name'], 'User');
      expect(json['email'], 'test@example.com');
      expect(json['photo'], 'photo.jpg');
      expect(json['authToken'], 'token_123');
      expect(json['gender'], '1');
    });

    test('Should handle null values in UserModel', () {
      final user = UserModel(
        userId: '1',
        patientId: null,
        doctorId: null,
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        photo: null,
        authToken: 'token',
        gender: null,
      );

      expect(user.patientId, isNull);
      expect(user.doctorId, isNull);
      expect(user.photo, isNull);
      expect(user.gender, isNull);
    });

    test('Should handle gender values correctly', () {
      // Мужской пол
      final maleUser = UserModel(
        userId: '1',
        patientId: 'pat_1',
        userName: 'maleuser',
        firstName: 'Male',
        lastName: 'User',
        email: 'male@example.com',
        authToken: 'token',
        gender: '1', // MALE
      );

      expect(maleUser.gender, '1');

      // Женский пол
      final femaleUser = UserModel(
        userId: '2',
        patientId: 'pat_2',
        userName: 'femaleuser',
        firstName: 'Female',
        lastName: 'User',
        email: 'female@example.com',
        authToken: 'token',
        gender: '2', // FEMALE
      );

      expect(femaleUser.gender, '2');
    });
  });
}

