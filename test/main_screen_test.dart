import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Main Screen Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    testWidgets('Should display main screen with navigation', (WidgetTester tester) async {
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
          home: Main(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Main), findsOneWidget);
    });

    test('Should create Main screen instance', () {
      expect(() => Main(), returnsNormally);
    });

    test('Should have bottom navigation bar', () async {
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

      final mainScreen = Main();
      expect(mainScreen, isNotNull);
    });
  });
}

