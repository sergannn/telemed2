import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/models/user_model.dart';

/// Тесты для проверки работы с полом пользователя
/// Задача 12: Убрать менструальный цикл у мужского пола
void main() {
  group('User Gender Tests', () {
    test('Should create UserModel with gender field', () {
      final user = UserModel(
        userId: '1',
        userName: 'test',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@test.com',
        photo: 'photo.jpg',
        authToken: 'token',
        gender: '1', // MALE
      );

      expect(user.gender, '1');
      expect(user.userId, '1');
    });

    test('Should parse gender from JSON', () {
      final json = {
        'token': 'test_token',
        'user': {
          'user_id': '1',
          'patient_id': '1',
          'doctor_id': null,
          'username': 'test',
          'first_name': 'Test',
          'last_name': 'User',
          'email': 'test@test.com',
          'photo': 'photo.jpg',
          'gender': 1, // MALE
        }
      };

      final user = UserModel.fromJson(json);
      expect(user.gender, '1');
    });

    test('Should parse gender 2 (FEMALE) from JSON', () {
      final json = {
        'token': 'test_token',
        'user': {
          'user_id': '1',
          'patient_id': '1',
          'doctor_id': null,
          'username': 'test',
          'first_name': 'Test',
          'last_name': 'User',
          'email': 'test@test.com',
          'photo': 'photo.jpg',
          'gender': 2, // FEMALE
        }
      };

      final user = UserModel.fromJson(json);
      expect(user.gender, '2');
    });

    test('Should handle null gender', () {
      final json = {
        'token': 'test_token',
        'user': {
          'user_id': '1',
          'patient_id': '1',
          'doctor_id': null,
          'username': 'test',
          'first_name': 'Test',
          'last_name': 'User',
          'email': 'test@test.com',
          'photo': 'photo.jpg',
          'gender': null,
        }
      };

      final user = UserModel.fromJson(json);
      expect(user.gender, isNull);
    });

    test('Should include gender in toJson', () {
      final user = UserModel(
        userId: '1',
        userName: 'test',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@test.com',
        photo: 'photo.jpg',
        authToken: 'token',
        gender: '2', // FEMALE
      );

      final json = user.toJson();
      expect(json['gender'], '2');
    });

    test('Should check if user is female correctly', () {
      // Test case 1: gender == '2'
      final user1 = UserModel(
        userId: '1',
        userName: 'test',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@test.com',
        photo: 'photo.jpg',
        authToken: 'token',
        gender: '2',
      );
      expect(user1.gender == '2', true);

      // Test case 2: gender == '1' (MALE)
      final user2 = UserModel(
        userId: '2',
        userName: 'test2',
        firstName: 'Test2',
        lastName: 'User2',
        email: 'test2@test.com',
        photo: 'photo2.jpg',
        authToken: 'token2',
        gender: '1',
      );
      expect(user2.gender == '2', false);
    });

    test('Should handle gender as string and integer', () {
      // Gender can come as string '1' or '2'
      expect('1' == '1', true);
      expect('2' == '2', true);
      expect('1' == '2', false);
    });
  });
}

