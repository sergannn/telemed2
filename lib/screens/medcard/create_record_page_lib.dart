import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'dart:convert';

class CalendarConstants {
  CalendarConstants._();

  static final DateTime maxDate = DateTime(275759);
  static final DateTime minDate = DateTime(-271819);
}

class AppColors {
  AppColors._();

  static const Color black = Color(0xff626262);
  static const Color white = Color(0xfff0f0f0);
  static const Color navyBlue = Color(0xff6471e9);
  static const Color lightNavyBlue = Color(0xffb3b9ed);
  static const Color red = Color(0xfff96c6c);
}

// enum CalendarView {
//   month,
//   day,
//   week,
// }

enum TimeStampFormat { parse_12, parse_24 }

// extension NavigationExtension on State {
//   void pushRoute(Widget page) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
// }

extension NavigatorExtention on BuildContext {
  // Future<T?> pushRoute<T>(Widget page) => Navigator.of(this).push<T>(MaterialPageRoute(builder: (context) => page));

  void pop([dynamic value]) => Navigator.of(this).pop(value);

  // void showSnackBarWithText(String text) => ScaffoldMessenger.of(this)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(SnackBar(content: Text(text)));
}

extension DateUtils on DateTime {
  String get weekdayToFullString {
    switch (weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "Error";
    }
  }

  String get weekdayToAbbreviatedString {
    switch (weekday) {
      case DateTime.monday:
        return "M";
      case DateTime.tuesday:
        return "T";
      case DateTime.wednesday:
        return "W";
      case DateTime.thursday:
        return "T";
      case DateTime.friday:
        return "F";
      case DateTime.saturday:
        return "S";
      case DateTime.sunday:
        return "S";
      default:
        return "Err";
    }
  }

  int get totalMinutes => hour * 60 + minute;

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );

  String dateToStringWithFormat({String format = 'y-M-d'}) {
    return DateFormat(format).format(this);
  }

  DateTime stringToDateWithFormat({
    required String format,
    required String dateString,
  }) =>
      DateFormat(format).parse(dateString);

  String getTimeInFormat(TimeStampFormat format) => DateFormat('h:mm${format == TimeStampFormat.parse_12 ? " a" : ""}').format(this).toUpperCase();

  bool compareTime(DateTime date) => hour == date.hour && minute == date.minute && second == date.second;
}

extension ColorExtension on Color {
  Color get accentColor {
    final brightness = ThemeData.estimateBrightnessForColor(this);
    return brightness == Brightness.light ? AppColors.black : AppColors.white;
  }
}

extension StringExt on String {
  String get capitalized => toBeginningOfSentenceCase(this) ?? "";
}

T? ambiguate<T>(T? object) => object;

extension DateTimeExtensions on DateTime {
  bool compareWithoutTime(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }

  int getMonthDifference(DateTime date) {
    if (year == date.year) return ((date.month - month).abs() + 1);

    var months = ((date.year - year).abs() - 1) * 12;

    if (date.year >= year) {
      months += date.month + (13 - month);
    } else {
      months += month + (13 - date.month);
    }

    return months;
  }

  String get formatted => "$month-$year";

  int get getTotalMinutes => hour * 60 + minute;

  DateTime copyFromMinutes([int totalMinutes = 0]) => DateTime(
        year,
        month,
        day,
        totalMinutes ~/ 60,
        totalMinutes % 60,
      );

  DateTime get withoutTime => DateTime(year, month, day);

  bool hasSameTimeAs(DateTime other) {
    return other.hour == hour && other.minute == minute && other.second == second && other.millisecond == millisecond && other.microsecond == microsecond;
  }

  bool get isDayStart => hour == 0 && minute == 0;

  @Deprecated("This extension is not being used in this package and will be removed "
      "in next major release. Please use withoutTime instead.")
  DateTime get dateYMD => DateTime(year, month, day);
}

extension MaterialColorExtension on MaterialColor {
  @Deprecated("This extension is not being used in this package and will be removed "
      "in next major release.")
  Color get accent => (blue / 2 >= 255 / 2 || red / 2 >= 255 / 2 || green / 2 >= 255 / 2) ? Colors.black : Colors.white;
}

extension TimerOfDayExtension on TimeOfDay {
  int get getTotalMinutes => hour * 60 + minute;
}

extension IntExtension on int {
  String appendLeadingZero() {
    return toString().padLeft(2, '0');
  }
}

void debugLog(String message) {
  assert(() {
    try {
      debugPrint(message);
    } catch (e) {} //ignore: empty_catches Suppress exception...

    return false;
  }(), '');
}

enum LineStyle {
  solid,
  dashed,
}

enum RecordCategory {
  Cat1,
  Cat2,
  Cat3,
}

enum DeleteRecord {
  all,
  current,
  following,
}

class CalendarRecordData<T extends Object?> {
  final DateTime date;
  final String title;
  final String? description;
  final T? event;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final String? category;

  CalendarRecordData({
    required this.title,
    required this.date,
    this.description,
    this.category,
    this.event,
    this.titleStyle,
    this.descriptionStyle,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date.toIso8601String(),
        "description": description,
        "category": category,
      };

  CalendarRecordData<T> copyWith({
    String? title,
    String? description,
    String? category,
    T? event,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    DateTime? date,
  }) {
    return CalendarRecordData(
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      event: event ?? this.event,
      titleStyle: titleStyle ?? this.titleStyle,
    );
  }

  @override
  String toString() => '${toJson()}';

  @override
  bool operator ==(Object other) {
    return other is CalendarRecordData<T> &&
        date.compareWithoutTime(other.date) &&
        ((event == null && other.event == null) || (event != null && other.event != null && event == other.event)) &&
        title == other.title &&
        category == other.category &&
        titleStyle == other.titleStyle &&
        descriptionStyle == other.descriptionStyle &&
        description == other.description;
  }

  @override
  int get hashCode => description.hashCode ^ descriptionStyle.hashCode ^ titleStyle.hashCode ^ title.hashCode ^ category.hashCode ^ date.hashCode;

  factory CalendarRecordData.fromJson(Map<String, dynamic> json) {
    return CalendarRecordData<T>(
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      category: json['category'] as String?,
    );
  }
}

class AppConstants {
  AppConstants._();

  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(
      width: 2,
      color: AppColors.lightNavyBlue,
    ),
  );

  static InputDecoration get inputDecoration => InputDecoration(
        border: inputBorder,
        disabledBorder: inputBorder,
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.red,
          ),
        ),
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        hintText: "Заголовок записи",
        hintStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
        ),
        labelStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
        ),
        helperStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
        ),
        errorStyle: TextStyle(
          color: AppColors.red,
          fontSize: 12,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      );
}
