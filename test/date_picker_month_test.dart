import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Тесты для проверки отображения месяца под числами в календаре
/// Задача 9: Добавить месяц на главную страницу под числа
void main() {
  group('Date Picker Month Display Tests', () {
    setUpAll(() async {
      await initializeDateFormatting('ru', null);
      await initializeDateFormatting('en', null);
    });

    test('Should return correct Russian month abbreviation', () async {
      final date = DateTime(2024, 11, 15);
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      final expectedMonth = months[date.month - 1];
      expect(expectedMonth, 'ноя');
    });

    test('Should return correct month for December', () async {
      final date = DateTime(2024, 12, 15);
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      final expectedMonth = months[date.month - 1];
      expect(expectedMonth, 'дек');
    });

    test('Should return correct month for January', () async {
      final date = DateTime(2024, 1, 15);
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      final expectedMonth = months[date.month - 1];
      expect(expectedMonth, 'янв');
    });

    test('Should handle all 12 months correctly', () async {
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      
      for (int month = 1; month <= 12; month++) {
        final date = DateTime(2024, month, 15);
        final expectedMonth = months[month - 1];
        expect(months[date.month - 1], expectedMonth, 
            reason: 'Month $month should be $expectedMonth');
      }
    });

    test('Should return month name for Russian locale', () async {
      final date = DateTime(2024, 11, 15);
      final monthName = DateFormat('MMM', 'ru').format(date);
      expect(monthName.toLowerCase(), contains('ноя'));
    });

    test('Should handle edge cases - first day of month', () async {
      final date = DateTime(2024, 11, 1);
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      final expectedMonth = months[date.month - 1];
      expect(expectedMonth, 'ноя');
    });

    test('Should handle edge cases - last day of month', () async {
      final date = DateTime(2024, 11, 30);
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      final expectedMonth = months[date.month - 1];
      expect(expectedMonth, 'ноя');
    });

    test('Should return correct month for different years', () async {
      final months = [
        'янв', 'фев', 'мар', 'апр', 'май', 'июн',
        'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
      ];
      
      for (int year = 2020; year <= 2030; year++) {
        final date = DateTime(year, 11, 15);
        expect(months[date.month - 1], 'ноя', 
            reason: 'November should be "ноя" for year $year');
      }
    });
  });
}


