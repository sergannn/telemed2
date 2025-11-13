import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/screens/home/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctorq/services/session.dart';
import 'golden_test_helper.dart';

void main() {
  group('HomeScreen Golden Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() {
      Get.testMode = true;
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('HomeScreen - initial state', (WidgetTester tester) async {
      await GoldenTestHelper.setUpGoldenTest(tester);
      
      await tester.pumpWidget(
        GoldenTestHelper.createTestApp(
          child: Scaffold(
            body: HomeScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // Find the first Scaffold (the one we created)
      final scaffoldFinder = find.byType(Scaffold).first;
      
      await expectLater(
        scaffoldFinder,
        matchesGoldenFile('golden/home_screen_initial.png'),
      );
    }, skip: false); // Now works on Linux

    testWidgets('HomeScreen - with date picker', (WidgetTester tester) async {
      await GoldenTestHelper.setUpGoldenTest(tester);
      
      await tester.pumpWidget(
        GoldenTestHelper.createTestApp(
          child: Scaffold(
            body: HomeScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 2));
      
      // Scroll to see date picker if needed
      final scrollable = find.byType(Scrollable);
      if (scrollable.evaluate().isNotEmpty) {
        await tester.drag(scrollable.first, const Offset(0, -100));
        await tester.pumpAndSettle();
      }
      
      // Find the first Scaffold (the one we created)
      final scaffoldFinder = find.byType(Scaffold).first;
      
      await expectLater(
        scaffoldFinder,
        matchesGoldenFile('golden/home_screen_with_date_picker.png'),
      );
    }, skip: false); // Now works on Linux
  });
}

