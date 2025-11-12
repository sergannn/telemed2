import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/screens/profile/health_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctorq/services/session.dart';
import 'golden_test_helper.dart';

void main() {
  group('HealthScreen Golden Tests (Doctor)', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    testWidgets('HealthScreen - initial state', (WidgetTester tester) async {
      GoldenTestHelper.setUpGoldenTest(tester);
      
      await tester.pumpWidget(
        GoldenTestHelper.createTestApp(
          child: Scaffold(
            body: HealthScreen(),
          ),
        ),
      );
      
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      // Find the first Scaffold (the one we created)
      final scaffoldFinder = find.byType(Scaffold).first;
      
      await expectLater(
        scaffoldFinder,
        matchesGoldenFile('golden/health_screen_initial.png'),
      );
    }, skip: false); // Now works on Linux
  });
}

