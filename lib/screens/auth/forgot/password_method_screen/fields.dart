import 'package:flutter/material.dart';

class PassFields {
  static getAll() {
    return _fields;
  }

  static final Map<String, dynamic> _fields = {
    'email': {
      'controller': TextEditingController(),
      'label': 'Адрес почты',
      'hint': 'example@mail.ru',
      'obscure': false,
      'validator': (value) => validateEmail(value) as String?,
    },
  };

  static validateEmail(v) {
    return 'Заполните поля корректно';
    return null;
  }
}
