import 'dart:convert';

import 'package:doctorq/models/user_model.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../constant/constants.dart';
import 'package:http/http.dart' as http;

GetIt getIt = GetIt.instance;

Future<bool> regUser(
    BuildContext context, String username, String password, String role) async {
  // try {
  printLog(username);
  printLog(password);

  // String loginString = '''
  //       mutation LoginUser {

  //         login(input: {username: "$username", password: "$password"}) {

  String loginString = '''

         mutation {
    registerUser(input: {
        email: "$username"
        name:  "$username"
        password:  "$password"
        password_confirmation: "$password"
        role: "$role"
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
  print("Status: ${result.hasException ? "Error" : "Success"}");
  print(result.exception.toString());
  if (result.exception.toString().contains("already been") &&
      username.contains("pan_")) {
    print("already");
    return true;
  }
  print("Data: ${jsonEncode(result.data)}");

  print(result.data?['graphqlErrors']);
//  print("Errors: ${result.ex .errors?.map((e) => jsonEncode(e)).toList() ?? []}");
  printLog(result.toString());
  if (result.data!["registerUser"]["status"] == 'MUST_VERIFY_EMAIL') {
    await authUser(context, username, password);
    return true;
  }
  if (result.hasException) {
    printLog(result.exception.toString());
    //УДАЛЕНИЕ ТУТ И ТАМ и проверить что всякое такое как популярные категории удалилось
    final errorMessages = {
      'incorrect_password': 'Неверный пароль.',
      'invalid_email': 'Неверный email.',
      'Internal server error': 'Ошибка сети или сервера.',
    };
    print(result.exception.toString());
    snackBar(context,
        message: "error",
//        message: errorMessages[result.exception] as String,
//            errorMessages[result.exception?.graphqlErrors[0].message] as String,
        color: Colors.red);
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
  /* print("Request Details:");
  print("Query: ${options.document}");
  print("Variables: ${options.variables}");
  print("Operation Name: ${options.operationName}");
//  print("Headers: ${options.headers}");
*/
  // Log response details
  print("\nResponse Details:");
  print("Status: ${result.hasException ? "Error" : "Success"}");
  print("Data: ${jsonEncode(result.data)}");
//  print("Errors: ${result.ex .errors?.map((e) => jsonEncode(e)).toList() ?? []}");
  printLog(result.toString());

  if (result.hasException) {
    printLog(result.exception.toString());
    //УДАЛЕНИЕ ТУТ И ТАМ и проверить что всякое такое как популярные категории удалилось
    final errorMessages = {
      'incorrect_password': 'Неверный пароль.',
      'invalid_email': 'Неверный email.',
      'Internal server error': 'Ошибка сети или сервера.',
    };
    print(result.exception.toString());
    snackBar(context,
        message: "error",
//        message: errorMessages[result.exception] as String,
//            errorMessages[result.exception?.graphqlErrors[0].message] as String,
        color: Colors.red);
    return false;
  }

  Map<String, dynamic> json = result.data!["loginwithuserresult"];
  print(json);
  UserModel user = UserModel.fromJson(json);

  await Session().saveUser(user);

  final userStore = getIt<UserStore>();
  userStore.setUserData(user.toJson());

  return true;
}

Future<String?> logOut() async {
  Session().removeUser();
  printLog('Logging out');
  return 'logged out';
}
