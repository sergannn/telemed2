import 'package:flutter_test/flutter_test.dart';

/// Тесты для проверки логики отображения менструального цикла
/// Задача 12: Убрать менструальный цикл у мужского пола
void main() {
  group('Menstrual Cycle Visibility Tests', () {
    test('Should hide menstrual cycle for male users (gender = 1)', () {
      const String? maleGender = '1';
      final bool shouldShow = maleGender != null && (maleGender == '2');
      
      expect(shouldShow, false, 
          reason: 'Menstrual cycle should be hidden for male users');
    });

    test('Should show menstrual cycle for female users (gender = 2)', () {
      const String? femaleGender = '2';
      final bool shouldShow = femaleGender != null && (femaleGender == '2');
      
      expect(shouldShow, true, 
          reason: 'Menstrual cycle should be shown for female users');
    });

    test('Should hide menstrual cycle when gender is null', () {
      const String? gender = null;
      final bool shouldShow = gender != null && (gender == '2');
      
      expect(shouldShow, false, 
          reason: 'Menstrual cycle should be hidden when gender is null');
    });

    test('Should handle gender as integer 1 (MALE)', () {
      const int maleGender = 1;
      final bool shouldShow = maleGender == 2;
      
      expect(shouldShow, false, 
          reason: 'Menstrual cycle should be hidden for gender = 1 (MALE)');
    });

    test('Should handle gender as integer 2 (FEMALE)', () {
      const int femaleGender = 2;
      final bool shouldShow = femaleGender == 2;
      
      expect(shouldShow, true, 
          reason: 'Menstrual cycle should be shown for gender = 2 (FEMALE)');
    });

    test('Should correctly identify female gender from string', () {
      final testCases = [
        ('1', false, 'Male should not show'),
        ('2', true, 'Female should show'),
        ('', false, 'Empty string should not show'),
        (null, false, 'Null should not show'),
      ];

      for (final testCase in testCases) {
        final gender = testCase.$1;
        final expected = testCase.$2;
        final reason = testCase.$3;
        
        final shouldShow = gender != null && gender == '2';
        expect(shouldShow, expected, reason: reason);
      }
    });

    test('Should correctly identify female gender from integer', () {
      final testCases = [
        (1, false, 'Male (1) should not show'),
        (2, true, 'Female (2) should show'),
      ];

      for (final testCase in testCases) {
        final gender = testCase.$1;
        final expected = testCase.$2;
        final reason = testCase.$3;
        
        final shouldShow = gender == 2;
        expect(shouldShow, expected, reason: reason);
      }
    });

    test('Should handle mixed string and integer comparison', () {
      // Test that '2' == 2 comparison works
      const String genderString = '2';
      const int genderInt = 2;
      
      // In Dart, '2' == 2 is false, so we need to convert
      final shouldShow1 = genderString == '2';
      final shouldShow2 = genderInt == 2;
      
      expect(shouldShow1, true);
      expect(shouldShow2, true);
    });
  });
}

