import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Session {
  static late SharedPreferences data; //TODO rename to storagePlace

  static Future init() async {
    //
    data = await SharedPreferences.getInstance(); // TODO as provider
  }

  static Future<UserModel?> getCurrentUser() async {
    //  if (!mounted) return null;

    // Initialize SharedPreferences if not done

    // Get user data from SharedPreferences
    String? userId = data.getString("user_id");
    String? userName = data.getString("username");
    String? email = data.getString("email");
    String? firstName = data.getString("first_name");
    String? lastName = data.getString("last_name");
    String? photo = data.getString("photo");
    String? authToken = data.getString("authToken");
    String? snils = data.getString("snils");
    String? phone = data.getString("phone");
    String? birthDate = data.getString("birth_date");

    // Create and return UserModel if all data is available
    if (userId != null &&
        userName != null &&
        email != null &&
        firstName != null &&
        lastName != null &&
        photo != null &&
        authToken != null) {
      return UserModel(
        userId: userId,
        patientId: data.getString("patient_id") ?? '',
        doctorId: data.getString("doctor_id") ?? '',
        userName: userName,
        email: email,
        firstName: firstName,
        lastName: lastName,
        photo: photo,
        authToken: authToken,
        snils: snils,
        phone: phone,
        birthDate: birthDate,
      );
    }

    // Return null if any required data is missing
    return null;
  }

  Future<UserModel> updateUserField(UserModel user,
      {required String fieldName, dynamic newValue}) async {
    if (user == null) {
      throw Exception('No user data found');
    }

    switch (fieldName.toLowerCase()) {
      case 'user_id':
        user.userId = newValue.toString();
        break;
      case 'username':
        user.userName = newValue.toString();
        break;
      case 'email':
        user.email = newValue.toString();
        break;
      case 'first_name':
        user.firstName = newValue.toString();
        break;
      case 'last_name':
        user.lastName = newValue.toString();
        break;
      case 'photo':
        print("saving photo");
        print(newValue.toString());

        user.photo = newValue.toString();
        break;
      case 'auth_token':
        user.authToken = newValue.toString();
        break;
      case 'snils':
        user.snils = newValue.toString();
        break;
      case 'phone':
        user.phone = newValue.toString();
        break;
      case 'birth_date':
        user.birthDate = newValue.toString();
        break;
      default:
        throw Exception('Invalid field name');
    }

    await saveUser(user);
//    PaintingBinding.instance.imageCache.clear();
//    DefaultCacheManager manager = new DefaultCacheManager();
//    manager.emptyCache(); //clears all data in cache.
    return user;
  }

  Future getUser() async {
    data.getBool("isLogin");
    data.getString("user_id");
    data.getString("username");
    data.getString("email");
    data.getString("first_name");
    data.getString("last_name");
    data.getString("photo");
    data.getString("authToken");
    data.getString("snils");
    data.getString("phone");
    data.getString("birth_date");
  }

  Future saveUser(UserModel user, {String cookie = ''}) async {
    data.setBool('isLogin', true);
    data.setString("user_id", user.userId!);
    data.setString("patient_id", user.patientId ?? '0');
    data.setString("doctor_id", user.doctorId ?? '0');
    data.setString("username", user.userName!);
    data.setString("email", user.email!);
    data.setString("first_name", user.firstName!);
    data.setString("last_name", user.lastName!);
    data.setString("photo", user.photo ?? '');
    data.setString("authToken", user.authToken!);
    data.setString("snils", user.snils ?? '');
    data.setString("phone", user.phone ?? '');
    data.setString("birth_date", user.birthDate ?? '');
    print(data);
    print(user.photo);
    return true;
  }

  void removeUser() async {
    data.setBool('isLogin', false);
    data.remove("id");
    data.remove("user_id");
    data.remove("username");
    data.remove("email");
    data.remove("first_name");
    data.remove("last_name");
    data.remove("photo");
    data.remove("authToken");
    data.remove("doctor_id");
    data.remove('patient_id');
    data.remove('snils');
    data.remove('phone');
    data.remove('birth_date');
    print("user saved");
  }

  Future<String?> getToken(args) async {
    final SharedPreferences storagePlace =
        await SharedPreferences.getInstance();
    String? token = storagePlace.getString("authToken");
    return token;
  }
}
