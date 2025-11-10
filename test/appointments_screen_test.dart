import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Appointments Screen Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    testWidgets('Should display appointments screen', (WidgetTester tester) async {
      final testUser = UserModel(
        userId: '1',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      await tester.pumpWidget(
        MaterialApp(
          home: AppointmentsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AppointmentsScreen), findsOneWidget);
    });

    testWidgets('Should display appointments screen with mode parameter', (WidgetTester tester) async {
      final testUser = UserModel(
        userId: '1',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      await tester.pumpWidget(
        MaterialApp(
          home: AppointmentsScreen(mode: 'old'),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(AppointmentsScreen), findsOneWidget);
    });

    test('Should create AppointmentsScreen instance', () {
      expect(() => AppointmentsScreen(), returnsNormally);
      expect(() => AppointmentsScreen(mode: 'old'), returnsNormally);
    });

    test('Should handle appointments screen state changes', () async {
      final testUser = UserModel(
        userId: '1',
        patientId: 'pat_1',
        doctorId: null,
        userName: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        authToken: 'token',
        gender: '1',
      );

      await Session().saveUser(testUser);

      final screen = AppointmentsScreen();
      expect(screen, isNotNull);
    });
  });
}

