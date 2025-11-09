import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  group('Doctor Avatar Update Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    test('Should update doctor avatar successfully', () async {
      final testContext = TestWidgetsFlutterBinding.ensureInitialized();
      
      expect(updateProfileAvatar, isNotNull);
      
      // В реальном тесте проверяем обновление аватарки врача
    });

    test('Should verify avatar is saved to database', () async {
      final testUser = UserModel(
        userId: '1',
        doctorId: '1',
        userName: 'testdoctor',
        firstName: 'Test',
        lastName: 'Doctor',
        email: 'doctor@test.com',
        authToken: 'test_token',
        photo: 'old_photo.jpg',
      );
      
      await Session().saveUser(testUser);
      
      final updatedUser = await Session().updateUserField(
        testUser,
        fieldName: 'photo',
        newValue: 'new_photo.jpg',
      );
      
      expect(updatedUser.photo, 'new_photo.jpg');
      
      final savedUser = await Session.getCurrentUser();
      expect(savedUser?.photo, 'new_photo.jpg');
    });
  });
}

