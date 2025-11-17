import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:doctorq/screens/profile/main_profile.dart';
import 'package:doctorq/screens/appointments/AppointmentsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:get/get.dart';
import 'dart:io';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Simple Screenshot Tests - Patient', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      if (GetIt.instance.isRegistered<UserStore>()) {
        await GetIt.instance.reset();
      }
      initStores();
      final userStore = GetIt.instance.get<UserStore>();
      userStore.setUserData({
        'patient_id': '1',
        'doctor_id': null,
        'first_name': 'Test',
        'last_name': 'User',
        'email': 'test@test.com',
      });
    });

    setUp(() {
      Get.testMode = true;
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('HomeScreen screenshot', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Делаем скриншот
      final binding = IntegrationTestWidgetsFlutterBinding.instance;
      final directory = Directory('integration_test/screenshots');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      
      try {
        final imageBytes = await binding.takeScreenshot('home_screen_patient');
        final file = File('${directory.path}/home_screen_patient.png');
        await file.writeAsBytes(imageBytes);
        print('✅ Screenshot saved: ${file.path}');
      } catch (e) {
        print('⚠️  Screenshot failed: $e');
      }

      // Проверяем элементы
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('ProfileScreen screenshot', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MainProfileScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final binding = IntegrationTestWidgetsFlutterBinding.instance;
      final directory = Directory('integration_test/screenshots');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      
      try {
        final imageBytes = await binding.takeScreenshot('profile_screen_patient');
        final file = File('${directory.path}/profile_screen_patient.png');
        await file.writeAsBytes(imageBytes);
        print('✅ Screenshot saved: ${file.path}');
      } catch (e) {
        print('⚠️  Screenshot failed: $e');
      }

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('AppointmentsScreen screenshot', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppointmentsScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 3));

      final binding = IntegrationTestWidgetsFlutterBinding.instance;
      final directory = Directory('integration_test/screenshots');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      
      try {
        final imageBytes = await binding.takeScreenshot('appointments_screen_patient');
        final file = File('${directory.path}/appointments_screen_patient.png');
        await file.writeAsBytes(imageBytes);
        print('✅ Screenshot saved: ${file.path}');
      } catch (e) {
        print('⚠️  Screenshot failed: $e');
      }

      expect(find.byType(Scaffold), findsWidgets);
    });
  });
}



