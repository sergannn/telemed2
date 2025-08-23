import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegFields {
  static getAll() {
    return _fields;
  }

  static Future<void> saveFields() async {
    final prefs = await SharedPreferences.getInstance();
    
    for (var entry in _fields.entries) {
      final key = entry.key;
      final field = entry.value;
      final controller = field['controller'] as TextEditingController;
      
      await prefs.setString('reg_$key', controller.text);
    }
  }
   static Future<void> loadFields() async {
    final prefs = await SharedPreferences.getInstance();
    
    for (var entry in _fields.entries) {
      final key = entry.key;
      final field = entry.value;
      final controller = field['controller'] as TextEditingController;
      
      controller.text = prefs.getString('reg_$key') ?? '';
    }
  }

  static final Map<String, dynamic> _tmpfields = {
    'email': {
      'controller': TextEditingController(),
      'label': 'Email!',
      'hint': 'example@mail.ru',
      'obscure': false,
      'validator': (value) => validateEmail(value) as String?,
    },
    'password': {
      'controller': TextEditingController(),
      'label': 'Password',
      'hint': 'Password',
      'obscure': true,
      'validator': (value) => validatePassword(value) as String?,
    },
    'firstName': {
      'controller': TextEditingController(),
      'label': 'First Name',
      'hint': 'First Name',
      'obscure': false,
      'validator': (value) => validateName(value) as String?,
    },
  };

  static final Map<String, dynamic> _fields = {
    'full_name': {
      "*": true,
      'controller': TextEditingController(),
      'label': 'ФИО',
      'hint': 'Иванов Иван Иванович',
      'obscure': false,
      'validator': (value) => validatePhone(value) as String?,
    },
    'birthday': {
      'type': 'date',
      'controller': TextEditingController(),
      'label': 'Дата рождения',
      'hint': '03.09.1987',
      'obscure': false,
      'validator': (value) => validateName(value) as String?,
    },
    'email': {
      'controller': TextEditingController(),
      'label': 'Электронная почта',
      'hint': 'example@mail.ru',
      'obscure': false,
      'validator': (value) => validateEmail(value) as String?,
    },
    'phone': {
      'controller': TextEditingController(),
      'label': 'Мобильный телефон',
      'hint': '8 921 345 54 35',
      'obscure': false,
      'validator': (value) => validateName(value) as String?,
    },
    'snils': {
      'controller': TextEditingController(),
      'label': 'Снилс',
      'hint': '8 921 345 54 35',
      'obscure': false,
      'validator': (value) => validateName(value) as String?,
    }
  };

  static validatePhone(value) {
    print(value);
    return null;
  }

  static validateName(value) {
    if (value.length == 0) return 'Заполните поля корректно';
    return null;
  }

  static validatePassword(value) {
    return null;
  }

  static validateEmail(v) {
    //return 'ploho';
    return null;
  }
}
