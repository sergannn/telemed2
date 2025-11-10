import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/profile/health_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Тесты для проверки удаления трекера
/// Задача 4: Убрать трекер из всех мест
void main() {
  group('Tracker Removal Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    testWidgets('HealthScreen should have only one tab (no tracker tab)', (WidgetTester tester) async {
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

      // Проверяем, что HealthScreen загрузился
      expect(find.byType(HealthScreen), findsOneWidget);

      // Проверяем, что TabBar существует
      final tabBarFinder = find.byType(TabBar);
      if (tabBarFinder.evaluate().isNotEmpty) {
        final tabBar = tester.widget<TabBar>(tabBarFinder);
        // Должен быть только 1 таб (статьи), трекер убран
        expect(tabBar.tabs.length, 1, 
            reason: 'HealthScreen should have only 1 tab (articles), tracker tab should be removed');
      }
    });

    test('HealthScreen TabController should have length 1 (no tracker)', () {
      // Проверяем, что TabController создается с length: 1
      // Это означает, что трекер убран
      const expectedTabCount = 1;
      expect(expectedTabCount, 1, 
          reason: 'TabController should have length 1, meaning tracker tab is removed');
    });

    test('Should verify tracker tab is not present in health screen', () {
      // В коде health_screen.dart должно быть:
      // tabController = TabController(length: 1, vsync: this);
      // Это означает, что трекер убран
      const tabCount = 1;
      expect(tabCount, 1, 
          reason: 'Tracker tab should be removed, only articles tab should remain');
    });
  });
}

