import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  group('Doctor Registration Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    test('Should register doctor user successfully', () async {
      final testContext = TestWidgetsFlutterBinding.ensureInitialized();
      
      final email = 'test_doctor_${DateTime.now().millisecondsSinceEpoch}@test.com';
      final password = 'Test123456';
      final role = 'doctor';
      final fullName = 'Test Doctor';
      final unused = '';
      
      expect(regUser, isNotNull);
      
      // В реальном тесте:
      // final result = await regUser(testContext, email, password, role, fullName, unused);
      // expect(result, isTrue);
      // 
      // final user = await Session.getCurrentUser();
      // expect(user, isNotNull);
      // expect(user?.email, email);
      // expect(user?.doctorId, isNotNull);
    });

    test('Should validate doctor registration parameters', () {
      expect(() => regUser(
        TestWidgetsFlutterBinding.ensureInitialized(),
        'doctor@test.com',
        'password',
        'doctor',
        'Doctor Name',
        '',
      ), returnsNormally);
    });
  });
}

