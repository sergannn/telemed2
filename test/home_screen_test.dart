import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Home Screen Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    testWidgets('Should display home screen with patient user', (WidgetTester tester) async {
      // Создаем тестового пользователя-пациента
      final patientUser = UserModel(
        userId: '1',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'patient',
        firstName: 'Patient',
        lastName: 'User',
        email: 'patient@example.com',
        authToken: 'token',
        gender: '2',
      );

      await Session().saveUser(patientUser);

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Проверяем, что экран загрузился
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Should display home screen with doctor user', (WidgetTester tester) async {
      // Создаем тестового пользователя-врача
      final doctorUser = UserModel(
        userId: '2',
        patientId: null,
        doctorId: 'doc_1',
        userName: 'doctor',
        firstName: 'Doctor',
        lastName: 'User',
        email: 'doctor@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(doctorUser);

      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Проверяем, что экран загрузился
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    test('Should handle home screen initialization', () {
      expect(() => HomeScreen(), returnsNormally);
    });
  });
}

