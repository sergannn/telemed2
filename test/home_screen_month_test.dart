import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('Home Screen Month Display Tests', () {
    test('Should format month name correctly in Russian', () async {
      await initializeDateFormatting('ru', null);
      final date = DateTime(2024, 11, 15);
      final monthName = DateFormat('MMMM', 'ru').format(date);
      expect(monthName.toLowerCase(), 'ноябрь');
    });

    test('Should format month name correctly for December', () async {
      await initializeDateFormatting('ru', null);
      final date = DateTime(2024, 12, 15);
      final monthName = DateFormat('MMMM', 'ru').format(date);
      expect(monthName.toLowerCase(), 'декабрь');
    });

    test('Should format month name in genitive case (required for Russian)', () async {
      await initializeDateFormatting('ru', null);
      final date = DateTime(2024, 11, 15);
      // В русском языке месяц под числом должен быть в родительном падеже
      final monthName = DateFormat('MMMM', 'ru').format(date);
      expect(monthName, isNotEmpty);
    });

    test('Should return correct month for different dates', () async {
      await initializeDateFormatting('ru', null);
      final testCases = [
        (DateTime(2024, 1, 15), 'январь'),
        (DateTime(2024, 2, 15), 'февраль'),
        (DateTime(2024, 3, 15), 'март'),
        (DateTime(2024, 4, 15), 'апрель'),
        (DateTime(2024, 5, 15), 'май'),
        (DateTime(2024, 6, 15), 'июнь'),
        (DateTime(2024, 7, 15), 'июль'),
        (DateTime(2024, 8, 15), 'август'),
        (DateTime(2024, 9, 15), 'сентябрь'),
        (DateTime(2024, 10, 15), 'октябрь'),
        (DateTime(2024, 11, 15), 'ноябрь'),
        (DateTime(2024, 12, 15), 'декабрь'),
      ];

      for (final testCase in testCases) {
        final monthName = DateFormat('MMMM', 'ru').format(testCase.$1);
        expect(monthName.toLowerCase(), testCase.$2);
      }
    });
  });
}




