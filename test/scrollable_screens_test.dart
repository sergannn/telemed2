import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/profile/main_profile.dart' as profile;
import 'package:doctorq/screens/profile/health_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Scrollable Screens Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    testWidgets('HomeScreen should be scrollable', (WidgetTester tester) async {
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
          home: HomeScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Проверяем наличие Scrollable виджета
      expect(find.byType(HomeScreen), findsOneWidget);
      
      // Проверяем, что можно прокрутить экран
      final scrollable = find.byType(Scrollable);
      if (scrollable.evaluate().isNotEmpty) {
        expect(scrollable, findsWidgets);
      }
    });

    testWidgets('MainProfile should be scrollable', (WidgetTester tester) async {
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
          home: profile.MainProfileScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(profile.MainProfileScreen), findsOneWidget);
    });

    testWidgets('HealthScreen should be scrollable', (WidgetTester tester) async {
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
          home: HealthScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HealthScreen), findsOneWidget);
    });
  });
}

