import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctorq/constant/constants.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/models/appointment_model.dart';
import 'package:doctorq/models/doctor_model.dart';
import 'package:doctorq/models/doctor_session_model.dart';
import 'package:doctorq/models/recommendation_model.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/stores/doctor_sessions_store.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/stores/specs_store.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/pub.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/services/fake_data_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<bool> getSpecs() async {
  printLog('Getting doctors');
  print("get specs");

  final response =
      await http.get(Uri.parse('https://admin.onlinedoctor.su/api/specializations'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    SpecsStore storeSpecsStore = getIt.get<SpecsStore>();
    storeSpecsStore.clearDoctorsData();
    jsonResponse.map((item) {
      //  var spec = SpecialistModel.fromJson(item);
      storeSpecsStore.addSpecToSpecsData(SpecialistModel.fromJson(item));
      return SpecialistModel.fromJson(item);
    }).toList();
  } else {
    throw Exception('Failed to load specialists');
  }

  return true;
}

Future<bool> cancelAppointment(id) async {
  var query = """mutation {
  cancelAppointment(id: "$id") {
    success
    message
    appointment {
      id
      status
    }
  }
}""";
  final QueryOptions options = QueryOptions(
    document: gql(query),
  );
  GraphQLClient graphqlClient = await graphqlAPI2.noauthClient();
  debugPrintTransactionStart('cancel appointment');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('query doctors');
  print(result);
  if (result.hasException) {}
  return true;
}

Future<bool> getDoctors() async {
  printLog('Getting doctors');
  print("getdoctors");
  String getDoctors = '''
    query doctors {
      doctors(first: 108) {
        data {
                                        doctorSession { id,
                                        sessionWeekDays {
                                  day_of_week
                                  start_time
                                  end_time
                                  doctor_session_id
                                }}
            doctor_id: id
            specializations {
                name
            }
              price
            doctorUser {
               	description
                user_id: id 
                username: full_name
                first_name
                last_name
                photo: profile_image
                qualifications {  degree university year}
            }
            reviews {
                id
                review
                rating
                created_at
                patient {
                    patientUser {
                        first_name
                        last_name
                    }
                }
            }
        }
        paginatorInfo {
          total
          currentPage
          hasMorePages
        }
      }
    }
  ''';

  final QueryOptions options = QueryOptions(
    document: gql(getDoctors),
  );
  // GraphQLClient graphqlClient = await graphqlAPI2.noauthClient();
  GraphQLClient graphqlClient = await graphqlAPI2.noauthClient();
  debugPrintTransactionStart('query doctors');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('query doctors');

  if (result.hasException) {
    printLog(result.exception.toString(), name: 'query doctors');
    // snackBar(context, message: result.exception.toString());
    return false;
  }
print(result.data);
  final json = result.data!["doctors"]["data"];

  DoctorsStore storeDoctorsStore = getIt.get<DoctorsStore>();

  storeDoctorsStore.clearDoctorsData();

  json.forEach((doctor) {
    DoctorModel doctorModel = DoctorModel.fromJson(doctor);
    storeDoctorsStore.addDoctorToDoctorsData(doctorModel.toJson());
  });

  return true;
}

Future<bool> setAppointment(
    {required String doctor_id,
    required String date,
    required String patient_id,
    required String status,
    required String from_time,
    required String from_time_type,
    required String to_time,
    required String to_time_type,
    required String description,
    required String service_id,
    required String payment_type,
    required String payable_amount}) async {
  printLog('Setting Appointments');

  // return true;

  String setAppointments = '''
       mutation {
         createAppointment(
           doctor_id: "$doctor_id"
           date: "$date"
           patient_id: "$patient_id"
           status: "$status"
           from_time: "$from_time"
           from_time_type: "$from_time_type"
           to_time: "$to_time"
           to_time_type: "$to_time_type"
           description: "$description"
           service_id: "$service_id"
           payment_type: "$payment_type"
           payable_amount: "$payable_amount"
         ) {
           id
         }
       }
  ''';
  print(setAppointments);
  printLog(setAppointments);

  final QueryOptions options = QueryOptions(
    document: gql(setAppointments),
  );
  GraphQLClient graphqlClient = await graphqlAPI2.noauthClient();
  debugPrintTransactionStart('mutation Appointments');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('mutation Appointments');

  if (result.hasException) {
    printLog(result.exception.toString(), name: 'mutation Appointments');
    // snackBar(context, message: result.exception.toString());
    return false;
  }

  final json = result.data!["createAppointment"]["id"];
  print(json);
  var app_id = json;
  printLog('createAppointment ${json}');

  String createRoomMutation = '''
    mutation {
      createroom(appointment_id: "$app_id") 
    }
  ''';
  print(createRoomMutation);
  final QueryOptions roomOptions = QueryOptions(
    document: gql(createRoomMutation),
  );

  final QueryResult roomResult = await graphqlClient.query(roomOptions);
  print("roomRes awaited");
  if (roomResult.hasException) {
    print(roomResult.exception.toString());
    printLog(roomResult.exception.toString(), name: 'Room mutation');
    return false;
  }
  print("still here");
  String roomId = jsonDecode(roomResult.data!["createroom"])["id"];
  print(roomId);
  printLog('Created Room $roomId');

  return true;
}

Future<bool> getAppointmentsD({required String doctorId}) async {
  // Генерируем фейковые данные для записей врача
  List<Map<String, dynamic>> fakeAppointments = FakeDataService.generateFakeAppointments(doctorId, 'doctor');
  
  AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();

  storeAppointmentsStore.clearAppointmentsData();
  
  printLog("Loading fake appointments data for doctor: $doctorId");
  
  fakeAppointments.forEach((appointment) {
    AppointmentModel appointmentModel = AppointmentModel.fromJson(appointment);
    storeAppointmentsStore
        .addAppointmentToAppointmentsData(appointmentModel.toJson());
  });

  return true;
}

Future<bool> getSessionsD({required String doctorId}) async {
  print(doctorId);
  
  // Генерируем фейковые данные для сеансов
  List<Map<String, dynamic>> fakeSessions = FakeDataService.generateFakeDoctorSessions(doctorId);
  
  DoctorSessionsStore storeDoctorSessionsStore =
      getIt.get<DoctorSessionsStore>();

  storeDoctorSessionsStore.clearDoctorSessionsData();

  printLog("Loading fake sessions data");

  fakeSessions.forEach((doctorSession) {
    DoctorSessionModel doctorSessionModel =
        DoctorSessionModel.fromJson(doctorSession);
    storeDoctorSessionsStore
        .addDoctorSessionToDoctorSessionsData(doctorSessionModel.toJson());
  });

  printLog("exit from getSessionsD with fake data");
  return true;
}

Future<bool> setSessionsD({required String doctorId}) async {
  printLog('Set Doctors Session');

  DoctorSessionsStore storeDoctorSessionsStore =
      getIt.get<DoctorSessionsStore>();

  Map<dynamic, dynamic> data =
      storeDoctorSessionsStore.doctorSessionsDataList[0];

  String myJsonString = jsonEncode(data["sessionWeekDays"]);

  String modifiedJsonString = myJsonString.replaceAllMapped(
      RegExp(r'"(\w+)"\s*:'), (match) => '${match.group(1)}:');

  String setDoctorSessions = '''
        mutation {
          upsertSessionsCustom(
              doctor_id: $doctorId
              session_meeting_time: ${data["session_meeting_time"]},
              session_gap: ${data["session_gap"]},
              sessionWeekDays: $modifiedJsonString
                              ) 
                              { 
                                id 
                              }
                  }
      ''';
  printLog(setDoctorSessions);
  print(setDoctorSessions);

  final QueryOptions options = QueryOptions(
    document: gql(setDoctorSessions),
  );

  GraphQLClient graphqlClient = await graphqlAPI2.noauthClient();

  debugPrintTransactionStart('mutation upsertSessionsCustom');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('mutation upsertSessionsCustom');

  if (result.hasException) {
    printLog(result.exception.toString(),
        name: 'mutation upsertSessionsCustom');
    return false;
  }

  final json = result.data?["upsertSessionsCustom"]["id"];
  printLog(json);

  printLog("exit from setSessionsD");
  return true;
}

Future<bool> getAppointments({required String patientId}) async {
  // Генерируем фейковые данные для записей пациента
  List<Map<String, dynamic>> fakeAppointments = FakeDataService.generateFakeAppointments(patientId, 'patient');
  
  AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();

  storeAppointmentsStore.clearAppointmentsData();
  
  printLog("Loading fake appointments data for patient: $patientId");

  fakeAppointments.forEach((appointment) {
    AppointmentModel appointmentModel = AppointmentModel.fromJson(appointment);
    storeAppointmentsStore
        .addAppointmentToAppointmentsData(appointmentModel.toJson());
  });

  return true;
}

Future<UserModel?> getCurrentUserDataAndReplaceField(
    String fieldName, dynamic newValue) async {
  final currentUser = await Session.getCurrentUser();

  if (currentUser != null) {
    print('current user not null');
    print(currentUser.toJson());
    return await Session()
        .updateUserField(currentUser, fieldName: fieldName, newValue: newValue);
  }

  return null;
}

Future<bool> updateProfileFields(BuildContext context,
    {String? first_name,
    String? last_name,
    String? sex,
    String? imagePath,
    String? phone,
    String? email}) async {
  // Get current user data to extract user_id
  final currentUser = await Session.getCurrentUser();
  if (currentUser == null) {
    print('No current user found');
    return false;
  }

  String? userId = currentUser.userId;
  if (userId == null) {
    print('User ID is null');
    return false;
  }

  //lk
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');
  String UPDATE_USER_PROFILE = '''
mutation UpdateUserProfile(\$input: UpdateUserProfileInput!) {
  updateUserProfile(input: \$input) {
    
    user {
      first_name
      last_name
      gender
      email
      profile_image
    }
  }
}
''';

// Usage example:
  final variables = {
    'input': {
      'user_id': userId, // Add the required user_id field
      'first_name': first_name,
      'last_name': last_name,
      'gender': sex,
      'email': email,
      'profile_image': imagePath
    }
  };
  print(UPDATE_USER_PROFILE);

  final uri = Uri.parse('https://admin.onlinedoctor.su/graphql');

  final request = http.MultipartRequest('post', uri);

  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'multipart/form-data';
  if (imagePath != null) {
    request.files.add(await http.MultipartFile.fromBytes(
      'profile_image',
      await File(imagePath).readAsBytes(),
      filename: 'avatar.jpg',
    ));
  }
  request.fields['map'] = json.encode({
    '0': ['updateUserProfile.input.profile_image']
  });

  request.fields['operations'] =
      json.encode({'query': UPDATE_USER_PROFILE, 'variables': variables});
  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  print(response.body);
  if (response.statusCode == 200) {
    print('Profile updated successfully!');

    Map<String, dynamic> json =
        jsonDecode(response.body)['data']['updateUserProfile'];
    print(json);
    print("it was json");
    final updatedUserData =
        await getCurrentUserDataAndReplaceField('photo', json['user']['photo']);
    // await getCurrentUserDataAndReplaceField('first_name', 's');
    if (updatedUserData != null) {
      print(updatedUserData.toJson());
      print("it was updated data");
      // User data has been successfully updated
      UserStore uStore = getIt.get<UserStore>();
      uStore.setUserData(updatedUserData.toJson());
      Session().saveUser(updatedUserData);
      // Session().saveUser(user);
    } else {
      // Error occurred during update
      print('Failed to update user data');
      return false;
    }
    return true;
  } else {
    print('Error: ${response.statusCode}');
    print(response.body);
    return false;
  }
}

Future<bool> updateProfileWithImage(BuildContext context, String imagePath,
    String firstName, String email) async {
  print(firstName + "," + email);
  //lk
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');
  final currentUser = await Session.getCurrentUser();
   String? userId = currentUser!.userId;
  var UPDATE_USER_PROFILE = '''
    mutation {
      updateUserProfile(
        input: {
          user_id:  "$userId",
          first_name: "$firstName",
          email: "$email",
          profile_image: null
        }
      ) {
          user {
        username:full_name
        user_id:id
        first_name
        last_name
        photo: profile_image
        email
      
        }
       
          status
    token
    role
      }
    }
  ''';
  print(UPDATE_USER_PROFILE);
  final uri = Uri.parse('https://admin.onlinedoctor.su/graphql');

  final request = http.MultipartRequest('post', uri);

  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'multipart/form-data';
  request.files.add(await http.MultipartFile.fromBytes(
    'profile_image',
    await File(imagePath).readAsBytes(),
    filename: 'avatar.jpg',
  ));

  request.fields['operations'] = json.encode({'query': UPDATE_USER_PROFILE});
  request.fields['map'] = json.encode({
    '0': ['updateUserProfile.input.profile_image']
  });

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  print(response.body);
  if (response.statusCode == 200) {
    print('Profile updated successfully!');

    Map<String, dynamic> json =
        jsonDecode(response.body)['data']['updateUserProfile'];
    print(json);
    print("it was json");
    final updatedUserData =
        await getCurrentUserDataAndReplaceField('photo', json['user']['photo']);
    // await getCurrentUserDataAndReplaceField('first_name', 's');
    if (updatedUserData != null) {
      print(updatedUserData.toJson());
      print("it was updated data");
      // User data has been successfully updated
      UserStore uStore = getIt.get<UserStore>();
      uStore.setUserData(updatedUserData.toJson());
      Session().saveUser(updatedUserData);
      // Session().saveUser(user);
    } else {
      // Error occurred during update
      print('Failed to update user data');
      return false;
    }
    return true;
  } else {
    print('Error: ${response.statusCode}');
    print(response.body);
    return false;
  }
}

Future<bool> updateProfileWithDocument(BuildContext context, String imagePath,
    String firstName, String email) async {
  print(firstName + "," + email);
  //lk
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');
  var UPDATE_USER_PROFILE = '''
    mutation {
      updateUserDocuments(
        input: {
          first_name: "$firstName",
          email: "$email",
          document_image: null
        }
      ) {
          user {
        username:full_name
        user_id:id
        first_name
        last_name
        photo: profile_image
        email
      
        }
       
          status
    token
    role
      }
    }
  ''';
  print(UPDATE_USER_PROFILE);
    final uri = Uri.parse('https://admin.onlinedoctor.su/graphql');
//  final uri = Uri.parse('https://onlinedoctor.su/graphql');

  final request = http.MultipartRequest('post', uri);

  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'multipart/form-data';
  request.files.add(await http.MultipartFile.fromBytes(
    'profile_image',
    await File(imagePath).readAsBytes(),
    filename: 'avatar.jpg',
  ));

  request.fields['operations'] = json.encode({'query': UPDATE_USER_PROFILE});
  request.fields['map'] = json.encode({
    '0': ['updateUserProfile.input.profile_image']
  });

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  print(response.body);
  if (response.statusCode == 200) {
    print('Profile updated successfully!');

    Map<String, dynamic> json =
        jsonDecode(response.body)['data']['updateUserProfile'];
    print(json);
    print("it was json");
    //   final updatedUserData =
    //       await getCurrentUserDataAndReplaceField('photo', json['user']['photo']);
    // await getCurrentUserDataAndReplaceField('first_name', 's');
//    if (updatedUserData != null) {
//      print(updatedUserData.toJson());
//      print("it was updated data");
    // User data has been successfully updated
//      UserStore uStore = getIt.get<UserStore>();
//      uStore.setUserData(updatedUserData.toJson());
//      Session().saveUser(updatedUserData);
    // Session().saveUser(user);
    //  } else {
    // Error occurred during update
    //   print('Failed to update user data');
    //    return false;
    //  }
    return true;
  } else {
    print('Error: ${response.statusCode}');
    print(response.body);
    return false;
  }
}

Future<List<RecommendationModel>> fetchRecommendations() async {
  printLog('Fetching recommendations');
  
  final response = await http.get(Uri.parse('https://admin.onlinedoctor.su/api/recommendations'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final data = (jsonData['data'] as List<dynamic>)
        .map((e) => RecommendationModel.fromJson(e))
        .toList();
    
    printLog('Successfully fetched ${data.length} recommendations');
    return data;
  } else {
    printLog('Failed to load recommendations: ${response.statusCode}');
    throw Exception('Failed to load recommendations');
  }
}

Future<bool> createReview({required String doctorId, required int rating, required String review}) async {
  printLog('Creating review for doctor: $doctorId');
  
  String createReviewMutation = '''
    mutation CreateReview(\$input: CreateReviewInput!) {
      createReview(input: \$input) {
        review {
          id
          rating
          review
          created_at
        }
        status
      }
    }
  ''';

  final variables = {
    'input': {
      'doctor_id': doctorId,
      'rating': rating,
      'review': review,
    }
  };

  final QueryOptions options = QueryOptions(
    document: gql(createReviewMutation),
    variables: variables,
  );

  GraphQLClient graphqlClient = await graphqlAPI2.authClient();
  debugPrintTransactionStart('mutation createReview');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('mutation createReview');

  if (result.hasException) {
    printLog(result.exception.toString(), name: 'mutation createReview');
    return false;
  }

  printLog('Review created successfully: ${result.data}');
  return true;
}
Future<List<Map<String, dynamic>>> fetchFAQs({String? category}) async {
  printLog('Fetching FAQs${category != null ? ' for category: $category' : ''}');
  
  String url = 'https://admin.onlinedoctor.su/api/faqs';
  if (category != null && (category == 'doctor' || category == 'patient')) {
    url += '?category=$category';
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final data = (jsonData['data'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    
    printLog('Successfully fetched ${data.length} FAQs');
    return data;
  } else {
    printLog('Failed to load FAQs: ${response.statusCode}');
    throw Exception('Failed to load FAQs');
  }
}


Future<List<Map<String, dynamic>>> fetchLegalInfos({String? type}) async {
  printLog('Fetching Legal Infos${type != null ? ' for type: $type' : ''}');
  
  String url = 'https://admin.onlinedoctor.su/api/legal-infos';
  if (type != null && (type == 'terms' || type == 'privacy' || type == 'license' || type == 'other')) {
    url += '?type=$type';
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final data = (jsonData['data'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    
    printLog('Successfully fetched ${data.length} legal infos');
    return data;
  } else {
    printLog('Failed to load legal infos: ${response.statusCode}');
    throw Exception('Failed to load legal infos');
  }
}