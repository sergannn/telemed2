import 'package:flutter/material.dart';

import '../services/graphql_setup.dart';

bool debugMode = const bool.fromEnvironment('TEST_MODE',
    defaultValue:
        true); // Включить Логгирование запросов принимая во внимание параметры запуска если не указано то defaultValue
bool debugResponceMode = const bool.fromEnvironment('TEST_RESPONCE_MODE',
    defaultValue:
        false); // Включить Логгирование запросов принимая во внимание параметры запуска если не указано то defaultValue
bool withSentry = const bool.fromEnvironment('WITH_SENTRY',
    defaultValue:
        true); // Включить Sentry принимая во внимание параметры запуска если не указано то defaultValue
bool forceSentry =
    true; // Принудительно включить Sentry не принимая во внимание параметры запуска

bool forceUserLogin = debugMode;
String testUserLogin = "doctor@infycare.com";
String testUserPassword = "123456";

const String kApiDomain = 'https://admin.onlinedoctor.su';
const String kApiDomain2 = 'https://admin.onlinedoctor.su';
//https://graph.free-dharma.ru/public';

MyAppAuthLib graphqlAPI = MyAppAuthLib(kApiDomain);
MyAppAuthLib graphqlAPI2 = MyAppAuthLib(kApiDomain2);

bool printedLog = true;
bool printedResult = true;

class Constants {
  static String currency = '\$';
  static Locale engLocal = const Locale('en');
  static Locale arLocal = const Locale('ar');
}
