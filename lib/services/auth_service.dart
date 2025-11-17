import 'dart:convert';
import 'dart:math';

import 'package:doctorq/models/user_model.dart';
import 'package:doctorq/services/notification_service.dart';
import 'package:doctorq/controllers/appointment_notification_controller.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../constant/constants.dart';
import 'package:http/http.dart' as http;

GetIt getIt = GetIt.instance;

Future<bool> regUser(BuildContext context, String email, String password,
    String role, String fullName, String unused) async {
  // try {
  printLog(email);
  printLog(password);

  // Use the fullName directly as the name field
  String name = fullName;
  print(fullName);
  // String loginString = '''
  //       mutation LoginUser {

  //         login(input: {username: "$username", password: "$password"}) {

  String loginString = '''

         mutation {
    registerUser(input: {
        email: "$email"
        name: "$name"
        password: "$password"
        password_confirmation: "$password"
        role: "$role"
        snils: "$unused"
        verification_url: {
          url: "https://onlinedoctor.su/api/verify-email?id=__ID__&token=__HASH__&expires=__EXPIRES__&signature=__SIGNATURE__"
        }
    }) {
        token
        status
    }
}
            
      ''';
  print(loginString);
  final MutationOptions options = MutationOptions(
    document: gql(loginString),
  );
  GraphQLClient graphqlClient = await graphqlAPI.noauthClient();
  debugPrintTransactionStart('mutation login');

  final QueryResult result = await graphqlClient.mutate(options);
  debugPrintTransactionEnd('mutation login');
  /* print("Request Details:");
  print("Query: ${options.document}");
  print("Variables: ${options.variables}");
  print("Operation Name: ${options.operationName}");
//  print("Headers: ${options.headers}");
*/
  // Log response details
  print("\nResponse Details:");
  print(result.toString());
  print("Status: ${result.hasException ? "Error" : "Success"}");
  print(result.exception.toString());
  print(result.toString());
  if (result.exception.toString().contains("already been") ) {
    print("already");
    return false;
  }
  print("Data: ${jsonEncode(result.data)}");

  print(result.data?['graphqlErrors']);
  print(result);

  printLog(result.toString());
  if (result.data!["registerUser"]["status"] == 'MUST_VERIFY_EMAIL') {
    await authUser(context, email, password);
    return true;
  }
  if (result.hasException) {
    printLog(result.exception.toString());
    
    // Проверяем наличие ошибки "The provided credentials are incorrect"
    final exceptionString = result.exception.toString();
    if (exceptionString.contains("The provided credentials are incorrect")) {
      snackBar(context,
          message: "Неверный email или пароль. Пожалуйста, проверьте введенные данные.",
          color: Colors.red);
    } else {
      // Обработка других ошибок
      final errorMessages = {
        'incorrect_password': 'Неверный пароль.',
        'invalid_email': 'Неверный email.',
        'Internal server error': 'Ошибка сети или сервера.',
      };
      
      // Попробуем найти подходящее сообщение об ошибке
      String errorMessage = "Произошла ошибка при входе";
      
      for (var errorKey in errorMessages.keys) {
        if (exceptionString.contains(errorKey)) {
          errorMessage = errorMessages[errorKey]!;
          break;
        }
      }
      
      snackBar(context,
          message: errorMessage,
          color: Colors.red);
    }
    return false;
  }

  Map<String, dynamic> json = result.data!["loginwithuserresult"];
  print(json);
  UserModel user = UserModel.fromJson(json);

  await Session().saveUser(user);

  final userStore = getIt<UserStore>();
  userStore.setUserData(user.toJson());
  //  {access_token: 7|XCLsXEtFXjCjOAglILNyxmsNDsKT9LDC6xCteAKEddaa9eda, user_id: 3, username: patient@infycare.com, photo: https://cdn.profi.ru/xfiles/pfiles/10c8fcca7d424731bd1c38eba954501b.jpg-profi_a34-320.jpg, name: null}
  // // inputDeviceToken(); // future for push notifications need token
  // Session.data.setString("user_json", jsonEncode(user.toJson()));

  return true;
}

Future<dynamic> fetchYaUserData(_token) async {
  final url = Uri.parse('https://login.yandex.ru/info?format=json');

  final headers = {
    'Authorization': 'OAuth $_token',
    'jwt_secret': '6806a03095124ec5862cf1d8465d74f6'
  };

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      //   print('Полученные данные пользователя: $data');
      return data;
    } else {
      print('Ошибка при получении данных: ${response.statusCode}');
    }
  } catch (e) {
    print('Произошла ошибка при выполнении запроса: $e');
  }
}

Future<bool> authUser(
    BuildContext context, String username, String password) async {
  // try {
  printLog(username);
  printLog(password);

  // String loginString = '''
  //       mutation LoginUser {

  //         login(input: {username: "$username", password: "$password"}) {

  String loginString = '''

            mutation {
                loginwithuserresult(input: {
                    email: "$username"
                    password: "$password"
                }) {
                    token
                    user {
                        user_id: id
                        username: full_name
                        email
                        first_name
                        last_name
                        photo: profile_image
                        patient_id
                        doctor_id
                        snils
                        phone: contact
                        birth_date: dob
                    }

                }
            }
            
      ''';
  print(loginString);
  final MutationOptions options = MutationOptions(
    document: gql(loginString),
  );
  GraphQLClient graphqlClient = await graphqlAPI.noauthClient();

  debugPrintTransactionStart('mutation login');

  final QueryResult result = await graphqlClient.mutate(options);
  debugPrintTransactionEnd('mutation login');
  print("\nResponse Details:");
  print("Status: ${result.hasException ? "Error" : "Success"}");
  print("Data: ${jsonEncode(result.data)}");
//  print("Errors: ${result.ex .errors?.map((e) => jsonEncode(e)).toList() ?? []}");
  printLog(result.toString());

  if (result.hasException) {
    printLog(result.exception.toString());
    
    // Проверяем наличие ошибки "The provided credentials are incorrect"
    final exceptionString = result.exception.toString();
    if (exceptionString.contains("The provided credentials are incorrect")) {
      snackBar(context,
          message: "Неверный email или пароль. Пожалуйста, проверьте введенные данные.",
          color: Colors.red);
    } else {
      // Обработка других ошибок
      final errorMessages = {
        'incorrect_password': 'Неверный пароль.',
        'invalid_email': 'Неверный email.',
        'Internal server error': 'Ошибка сети или сервера.',
      };
      
      // Попробуем найти подходящее сообщение об ошибке
      String errorMessage = "Произошла ошибка при входе";
      
      for (var errorKey in errorMessages.keys) {
        if (exceptionString.contains(errorKey)) {
          errorMessage = errorMessages[errorKey]!;
          break;
        }
      }
      
      snackBar(context,
          message: errorMessage,
          color: Colors.red);
    }
    return false;
  }

  Map<String, dynamic> json = result.data!["loginwithuserresult"];
  print(json);
  UserModel user = UserModel.fromJson(json);

  await Session().saveUser(user);

  final userStore = getIt<UserStore>();
  userStore.setUserData(user.toJson());
  print("we are authing");
  // Start checking for new appointments if user is a doctor
  if (user.doctorId != null) {
    print("not null");
    // Инициализировать NotificationService для показа уведомлений
    final notificationService = getIt<NotificationService>();
    print("initing");
    await notificationService.initialize();
    
    // Запустить RxController для периодической проверки
    final appointmentController = Get.put(AppointmentNotificationController());
    await appointmentController.startChecking(user.doctorId!);
    print('Started appointment checking for doctor: ${user.doctorId}');
  }

  return true;
}

String generateRandomCode() {
  final random = Random();
  String code = '';
  for (int i = 0; i < 4; i++) {
    code += random.nextInt(10).toString();
  }
  return code;
}

Future<Map<String, dynamic>?> sendEmail(email, code) async {
  final url = Uri.parse('https://derevni-i-syola.ru/test-mail/$email/$code');
  print(url);
  final response = await http.get(url);

  print(response.body);
  if (response.statusCode == 200) {
    print({'response': response.body, 'code': code});
    return {'response': response.body, 'code': code, 'email': email};
  } else {
    return {'response': response.body, 'code': code, 'email': email};
  }
}

Future<Map<String, dynamic>?> sendSMS(tel, code) async {
  final url = Uri.parse('https://api.exolve.ru/messaging/v1/SendSMS');
  print(tel);
  final headers = {
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJRV05sMENiTXY1SHZSV29CVUpkWjVNQURXSFVDS0NWODRlNGMzbEQtVHA0In0.eyJleHAiOjIwNTc3MDQxMTgsImlhdCI6MTc0MjM0NDExOCwianRpIjoiNzQ1NGVhMGItZGI5OS00ZWU3LWE0ZWMtZWZiOGFmYzdkOGVkIiwiaXNzIjoiaHR0cHM6Ly9zc28uZXhvbHZlLnJ1L3JlYWxtcy9FeG9sdmUiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiOTVkNzJmYzgtZjNkYS00MmQ2LWJiNTAtOWIzMWZkNmU2YzkwIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiNDg0NjRlMTMtODUzNC00ZDYyLTliNTEtMDAyNmY4ZmI4NmE0Iiwic2Vzc2lvbl9zdGF0ZSI6ImE0NTE5Mzk1LWM0ZDQtNDY3Yi05YWMzLWZkMGUxZGY5MWM2MiIsImFjciI6IjEiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1leG9sdmUiLCJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJleG9sdmVfYXBwIHByb2ZpbGUgZW1haWwiLCJzaWQiOiJhNDUxOTM5NS1jNGQ0LTQ2N2ItOWFjMy1mZDBlMWRmOTFjNjIiLCJ1c2VyX3V1aWQiOiI2YWU4NTg4NS00ZDM1LTQ1MzItYWNmYi05ODkzNGU2ZjNlNjgiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImNsaWVudElkIjoiNDg0NjRlMTMtODUzNC00ZDYyLTliNTEtMDAyNmY4ZmI4NmE0IiwiY2xpZW50SG9zdCI6IjE3Mi4xNi4xNjEuMTkiLCJhcGlfa2V5Ijp0cnVlLCJhcGlmb25pY2Ffc2lkIjoiNDg0NjRlMTMtODUzNC00ZDYyLTliNTEtMDAyNmY4ZmI4NmE0IiwiYmlsbGluZ19udW1iZXIiOiIxMzAwNDA4IiwiYXBpZm9uaWNhX3Rva2VuIjoiYXV0YmZkMzU3M2EtODIyMC00Mjg1LWJjY2MtYzYxMDk4MjQ2OGU0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoic2VydmljZS1hY2NvdW50LTQ4NDY0ZTEzLTg1MzQtNGQ2Mi05YjUxLTAwMjZmOGZiODZhNCIsImN1c3RvbWVyX2lkIjoiMTA1MzA4IiwiY2xpZW50QWRkcmVzcyI6IjE3Mi4xNi4xNjEuMTkifQ.UVoabXQwZg15v638SJrsTwRFfpUZRnMfgShFEaBJ6ZtBlG9siaKzYqgtqLrdjA5yIji9ZIsASgpTaxPhMDOSwPDcEPa4c3nlUqBtTeFBO8_c1gxtAJK2ADjFjeL5Fupg6T6vaSmtXaHS9r6HFgXg5u0V1HXhUqqHaGKCm_UvizROQ12WjP-u5VRjGjXw4mYlH3ERn51DX5l6tgRt6EP63720FJYijElu5Cs19jXbtF1FAlx_EAgpFRjv3BUImvGLlXizBwspdfWWT4UIq703Fo9kGUQ1HPnayOmoM2AdcO5RyfBsAkDKlfSZenh8S0BBbK977IXCzohpV12BZbgOJQ'
  };

  try {
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "number": "79587120489", // номер отправителя
          "destination": tel, // номер получателя
          "text": code // текст сообщения
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print({'response': response.body, 'code': code});
      return {'response': response.body, 'code': code, 'phone': tel};
    } else {
      throw Exception('Failed to send SMS: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending SMS: $e');
    throw Exception('Error sending SMS: $e');
  }
}

Future<String?> logOut() async {
  // Остановить проверку новых записей
  if (Get.isRegistered<AppointmentNotificationController>()) {
    final appointmentController = Get.find<AppointmentNotificationController>();
    appointmentController.stopChecking();
    Get.delete<AppointmentNotificationController>();
    printLog('Appointment notification controller stopped');
  }
  
  Session().removeUser();
  printLog('Logging out');
  return 'logged out';
}
Future<bool> checkEmailExists(String email) async {
  try {
    String checkEmailQuery = '''
      query CheckEmail(\$email: String) {
        users(email: \$email, first:100) {
          data {
            id
            email
          }
        }
      }
    ''';
    
    final QueryOptions options = QueryOptions(
      document: gql(checkEmailQuery),
      variables: {'email': email},
    );
    GraphQLClient graphqlClient = await graphqlAPI2.noauthClient();
    
    final QueryResult result = await graphqlClient.query(options);
    
    if (result.hasException) {
      printLog('Email check error: ${result.exception}');
      return false; // Assume email doesn't exist if there's an error
    }
    
    final users = result.data?['users']['data'] ?? [];
    return users.isNotEmpty;
  } catch (e) {
    printLog('Email check failed: $e');
    return false;
  }
}
