import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:doctorq/screens/medcard/card_gallery.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('MedCard Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await Session.init();
    });

    testWidgets('Should display medical card screen', (WidgetTester tester) async {
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
          home: MedCardScreen(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MedCardScreen), findsOneWidget);
    });

    test('Should create MedCardScreen instance', () {
      expect(() => MedCardScreen(), returnsNormally);
    });
  });
}

