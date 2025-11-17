/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class GregorianDateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  GregorianDateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  String _getMonthName(DateTime date, String locale) {
    try {
      // Используем короткое название месяца в родительном падеже для русского
      if (locale == 'ru' || locale == 'ru_RU') {
        final months = [
          'янв', 'фев', 'мар', 'апр', 'май', 'июн',
          'июл', 'авг', 'сен', 'окт', 'ноя', 'дек'
        ];
        return months[date.month - 1];
      }
      // Для других языков используем стандартный формат
      return DateFormat('MMM', locale).format(date);
    } catch (e) {
      // Fallback на английский
      return DateFormat('MMM', 'en').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = locale ?? 'ru';
    final monthName = _getMonthName(date, currentLocale);
    
    return InkWell(
      customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
//          borderRadius: const BorderRadius.all(Radius.circular(38.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                date.day.toString(),
                textAlign: TextAlign.center,
                style: dateTextStyle,
              ),
              SizedBox(height: 2),
              // Добавляем месяц под числом мелким серым шрифтом
              Text(
                monthName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        print("tap");
        onDateSelected?.call(this.date);
      },
    );
  }
}
