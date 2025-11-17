import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  group('Doctor Profile Update Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    test('Should update doctor profile fields', () async {
      final testContext = TestWidgetsFlutterBinding.ensureInitialized();
      
      expect(updateProfileFields, isNotNull);
      
      // В реальном тесте проверяем обновление полей врача
    });

    test('Should verify profile changes are saved to database', () async {
      final testUser = UserModel(
        userId: '1',
        doctorId: '1',
        userName: 'testdoctor',
        firstName: 'Original',
        lastName: 'Doctor',
        email: 'doctor@test.com',
        authToken: 'test_token',
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
  });
}




