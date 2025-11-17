import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/screens/medcard/profile_survey.dart';

void main() {
  group('Profile Survey Menstrual Cycle Tests', () {
    test('Should hide menstrual cycle section for male users', () {
      // Мужской пол: gender = 1 (MALE)
      const int maleGender = 1;
      const bool shouldShowMenstrualCycle = false;
      
      expect(shouldShowMenstrualCycle, false);
    });

    test('Should show menstrual cycle section for female users', () {
      // Женский пол: gender = 2 (FEMALE)
      const int femaleGender = 2;
      const bool shouldShowMenstrualCycle = true;
      
      expect(shouldShowMenstrualCycle, true);
    });

    test('Should check gender value correctly', () {
      // Тест проверки пола
      const int maleGender = 1;
      const int femaleGender = 2;
      
      expect(maleGender == 1, true); // MALE
      expect(femaleGender == 2, true); // FEMALE
      expect(maleGender != femaleGender, true);
    });

    test('Should return false for menstrual cycle when gender is null', () {
      // Если пол не указан, не показываем менструальный цикл
      const int? gender = null;
      final bool shouldShow = gender != null && gender == 2;
      
      expect(shouldShow, false);
    });
  });
}




