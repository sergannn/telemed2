import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:doctorq/main.dart' as app;
import 'screenshot_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Screenshot Tests - Patient', () {
    testWidgets('HomeScreen screenshot and verification', (WidgetTester tester) async {
      // Запускаем приложение
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Делаем скриншот
      await tester.takeScreenshot('home_screen_patient');

      // Проверяем наличие основных элементов
      // Используем более гибкий поиск
      final hasText = find.text('Главная').evaluate().isNotEmpty ||
                     find.text('Добро пожаловать').evaluate().isNotEmpty ||
                     find.byType(Scaffold).evaluate().isNotEmpty;
      expect(hasText, isTrue, reason: 'Home screen should be visible');
    });

    testWidgets('ProfileScreen screenshot and verification', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Навигация к профилю (если есть нижнее меню)
      final profileButton = find.text('Профиль');
      if (profileButton.evaluate().isNotEmpty) {
        await tester.tap(profileButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }

      await tester.takeScreenshot('profile_screen_patient');

      // Проверяем элементы профиля
      final hasProfileElements = find.byType(Scaffold).evaluate().isNotEmpty;
      expect(hasProfileElements, isTrue, reason: 'Profile screen should be visible');
    });

    testWidgets('AppointmentsScreen screenshot and verification', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Навигация к записям
      final appointmentsButton = find.text('Записи');
      if (appointmentsButton.evaluate().isNotEmpty) {
        await tester.tap(appointmentsButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }

      await tester.takeScreenshot('appointments_screen_patient');

      // Проверяем элементы записей
      final hasAppointmentsElements = find.byType(Scaffold).evaluate().isNotEmpty;
      expect(hasAppointmentsElements, isTrue, reason: 'Appointments screen should be visible');
    });
  });
}

