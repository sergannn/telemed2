import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctorq/constant/constants.dart';
import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/models/appointment_model.dart';
import 'package:doctorq/models/doctor_model.dart';
import 'package:doctorq/models/doctor_session_model.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/stores/doctor_sessions_store.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/stores/specs_store.dart';
import 'package:doctorq/stores/user_store.dart';
//import 'package:doctorq/stores/user_store.dart'
import 'package:doctorq/utils/pub.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

// Timeout configuration for GraphQL requests
const Duration defaultTimeout = Duration(seconds: 30);
const int maxRetries = 3;
const Duration retryDelay = Duration(seconds: 2);

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
            doctorUser {
                user_id: id 
                username: full_name
                first_name
                last_name
                photo: profile_image
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
  GraphQLClient graphqlClient = await graphqlAPI.noauthClient();
  debugPrintTransactionStart('query doctors');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('query doctors');

  if (result.hasException) {
    printLog(result.exception.toString(), name: 'query doctors');
    // snackBar(context, message: result.exception.toString());
    return false;
  }

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
  GraphQLClient graphqlClient = await graphqlAPI.noauthClient();
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

/// Execute GraphQL query with retry logic
Future<QueryResult> _executeQueryWithRetry({
  required QueryOptions options,
  bool authenticated = false,
}) async {
  int attempt = 0;
  Exception? lastException;
  
  while (attempt < maxRetries) {
    try {
      final GraphQLClient graphqlClient = authenticated 
          ? await graphqlAPI.authClient() 
          : await graphqlAPI.noauthClient();
      
      // Execute with timeout
      return await graphqlClient.query(options).timeout(defaultTimeout);
    } on TimeoutException {
      attempt++;
      lastException = Exception('Request timeout (attempt $attempt/$maxRetries)');
      printLog('GraphQL request timeout, attempt $attempt/$maxRetries');
      
      if (attempt < maxRetries) {
        await Future.delayed(retryDelay * attempt); // Exponential backoff
      }
    } on ServerException catch (e) {
      attempt++;
      lastException = e;
      printLog('GraphQL server error: ${e.originalException}, attempt $attempt/$maxRetries');
      
      // Check if it's a connection error that might benefit from retry
      final errorStr = e.originalException.toString();
      if (errorStr.contains('Connection closed') || 
          errorStr.contains('Connection refused') ||
          errorStr.contains('SocketException')) {
        if (attempt < maxRetries) {
          await Future.delayed(retryDelay * attempt);
        }
      } else {
        // For other server errors, don't retry
        rethrow;
      }
    } catch (e) {
      attempt++;
      lastException = Exception('GraphQL request failed: $e');
      printLog('GraphQL request error: $e, attempt $attempt/$maxRetries');
      
      if (attempt < maxRetries) {
        await Future.delayed(retryDelay * attempt);
      }
    }
  }
  
  // After all retries failed, throw the last exception
  throw lastException ?? Exception('Max retries exceeded for GraphQL request');
}

Future<bool> getAppointmentsD({required String doctorId}) async {
  print("DEBUG: Getting appointments for doctor: $doctorId");
  
  AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();
  storeAppointmentsStore.clearAppointmentsData();

  try {
    final QueryOptions options = QueryOptions(
      document: gql('''
        query appointments {
          appointmentsbydoctor(doctor_id: "$doctorId") {
            id
            date
            appointment_unique_id
            patient {
              patientUser {
                id
                full_name 
                first_name
                profile_image
              }
            }
            doctor {
              doctor_id: id
              specializations {
                name
              }
            }
            status
            from_time
            from_time_type
            to_time
            to_time_type
            description
            room_data
          }
        }
      '''),
    );

    final result = await _executeQueryWithRetry(options: options);

    if (result.hasException) {
      print("DEBUG: GraphQL error: ${result.exception}");
      return false;
    }

    print("DEBUG: GraphQL result: ${result.data}");
    
    if (result.data != null && result.data!['appointmentsbydoctor'] != null) {
      List<dynamic> appointments = result.data!['appointmentsbydoctor'];
      print("DEBUG: Found ${appointments.length} appointments");
      
      // Детальная проверка структуры данных
      if (appointments.isNotEmpty) {
        final firstAppointment = appointments[0];
        print("DEBUG: First appointment structure: ${firstAppointment}");
        print("DEBUG: First appointment keys: ${firstAppointment.keys.toList()}");
        print("DEBUG: Room data in first appointment: ${firstAppointment['room_data']}");
        print("DEBUG: Room data type: ${firstAppointment['room_data']?.runtimeType}");
      }
      
      // Логирование сырых полей времени с бэкенда (для проверки 28:00 / 72 часа)
      for (int i = 0; i < appointments.length; i++) {
        final a = appointments[i];
        print("DEBUG BACKEND TIME [doctor] appointment id=${a['id']} date=${a['date']} | from_time=${a['from_time']} (${a['from_time']?.runtimeType}) | from_time_type=${a['from_time_type']} | to_time=${a['to_time']} | to_time_type=${a['to_time_type']}");
      }
      
      appointments.forEach((appointment) {
        print("DEBUG: Processing appointment: ${appointment['id']}");
        try {
          AppointmentModel appointmentModel = AppointmentModel.fromJson(appointment);
          print("DEBUG: AppointmentModel created successfully");
          storeAppointmentsStore.addAppointmentToAppointmentsData(appointmentModel.toJson());
          print("DEBUG: Appointment added to store");
        } catch (e) {
          print("DEBUG: Error creating AppointmentModel: $e");
          print("DEBUG: Appointment data: $appointment");
        }
      });
      
      print("DEBUG: Added ${storeAppointmentsStore.appointmentsDataList.length} appointments to store");
      return true;
    } else {
      print("DEBUG: No appointments data found");
      return false;
    }
  } catch (e) {
    print("DEBUG: Error getting appointments: $e");
    return false;
  }
}

Future<bool> getSessionsD({required String doctorId}) async {
  print("DEBUG: Getting sessions for doctor: $doctorId");
  
  DoctorSessionsStore storeDoctorSessionsStore = getIt.get<DoctorSessionsStore>();
  storeDoctorSessionsStore.clearDoctorSessionsData();

  try {
    final QueryOptions options = QueryOptions(
      document: gql('''
        query sessions {
          sessionsBydoctorId(doctor_id: $doctorId) {
            id
            doctor_id
            session_meeting_time
            session_gap
            sessionWeekDays {
              id
              day_of_week
              start_time
              end_time
              start_time_type
              end_time_type
            }
          }
        }
      '''),
      variables: {'doctorId': doctorId},
    );

    final result = await _executeQueryWithRetry(options: options);

    if (result.hasException) {
      print("DEBUG: GraphQL error: ${result.exception}");
      return false;
    }

    print("DEBUG: GraphQL result: ${result.data}");
    
    if (result.data != null && result.data!['sessionsBydoctorId'] != null) {
      List<dynamic> sessions = result.data!['sessionsBydoctorId'];
      print("DEBUG: Found ${sessions.length} sessions");
      
      sessions.forEach((session) {
        DoctorSessionModel doctorSessionModel = DoctorSessionModel.fromJson(session);
        storeDoctorSessionsStore.addDoctorSessionToDoctorSessionsData(doctorSessionModel.toJson());
      });
      
      print("DEBUG: Added ${storeDoctorSessionsStore.doctorSessionsDataList.length} sessions to store");
      return true;
    } else {
      print("DEBUG: No sessions data found");
      return false;
    }
  } catch (e) {
    print("DEBUG: Error getting sessions: $e");
    return false;
  }
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

  GraphQLClient graphqlClient = await graphqlAPI.noauthClient();

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
  print("DEBUG: Getting appointments for patient: $patientId");
  
  AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();
  storeAppointmentsStore.clearAppointmentsData();

  try {
    final QueryOptions options = QueryOptions(
      document: gql('''
        query appointments {
          appointmentsbypatient(patient_id: "$patientId") {
            id
            date
            appointment_unique_id
            patient {
              patientUser {
                id
                full_name 
                first_name
                profile_image
              }
            }
            doctor {
              doctor_id: id
              specializations {
                name
              }
            }
            status
            from_time
            from_time_type
            to_time
            to_time_type
            description
            room_data
          }
        }
      '''),
    );

    final result = await _executeQueryWithRetry(options: options);

    if (result.hasException) {
      print("DEBUG: GraphQL error: ${result.exception}");
      return false;
    }

    print("DEBUG: GraphQL result: ${result.data}");
    
    if (result.data != null && result.data!['appointmentsbypatient'] != null) {
      List<dynamic> appointments = result.data!['appointmentsbypatient'];
      print("DEBUG: Found ${appointments.length} appointments");
      
      // Логирование сырых полей времени с бэкенда (для проверки 28:00 / 72 часа)
      for (int i = 0; i < appointments.length; i++) {
        final a = appointments[i];
        print("DEBUG BACKEND TIME [patient] appointment id=${a['id']} date=${a['date']} | from_time=${a['from_time']} (${a['from_time']?.runtimeType}) | from_time_type=${a['from_time_type']} | to_time=${a['to_time']} | to_time_type=${a['to_time_type']}");
      }
      
      appointments.forEach((appointment) {
        AppointmentModel appointmentModel = AppointmentModel.fromJson(appointment);
        storeAppointmentsStore.addAppointmentToAppointmentsData(appointmentModel.toJson());
      });
      
      print("DEBUG: Added ${storeAppointmentsStore.appointmentsDataList.length} appointments to store");
      return true;
    } else {
      print("DEBUG: No appointments data found");
      return false;
    }
  } catch (e) {
    print("DEBUG: Error getting appointments: $e");
    return false;
  }
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
//  print(first_name + "," + email );
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

Future<bool> createDoctorReview({required String patientId, required int rating, required String review}) async {
  printLog('Creating doctor review for patient: $patientId');
  
  String createDoctorReviewMutation = '''
    mutation CreateDoctorReview(\$input: CreateDoctorReviewInput!) {
      createDoctorReview(input: \$input) {
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
      'patient_id': patientId,
      'rating': rating,
      'review': review,
    }
  };

  final QueryOptions options = QueryOptions(
    document: gql(createDoctorReviewMutation),
    variables: variables,
  );

  GraphQLClient graphqlClient = await graphqlAPI.authClient();
  debugPrintTransactionStart('mutation createDoctorReview');
  final QueryResult result = await graphqlClient.query(options);
  debugPrintTransactionEnd('mutation createDoctorReview');

  if (result.hasException) {
    printLog(result.exception.toString(), name: 'mutation createDoctorReview');
    return false;
  }

  printLog('Doctor review created successfully: ${result.data}');
  return true;
}

Future<bool> getPatientsForDoctor({required String doctorId}) async {
  print('DEBUG: Getting patients for doctor: $doctorId');
  
  try {
    // First get appointments for the doctor
    bool success = await getAppointmentsD(doctorId: doctorId);
    print('DEBUG: getAppointmentsD success: $success');
    
    if (!success) {
      print('DEBUG: Failed to get appointments for doctor');
      return false;
    }
  } catch (e) {
    print('DEBUG: Error in getAppointmentsD: $e');
    return false;
  }
  
  try {
    // Get the appointments store to extract patients
    AppointmentsStore storeAppointmentsStore = getIt.get<AppointmentsStore>();
    List<dynamic> appointments = storeAppointmentsStore.appointmentsDataList;
    print('DEBUG: Found ${appointments.length} appointments');
    
    // Extract unique patients from appointments
    Set<String> uniquePatientIds = {};
    List<Map<String, dynamic>> patients = [];
    
    for (var appointment in appointments) {
      print('DEBUG: Processing appointment: ${appointment['id']}');
      print('DEBUG: Patient data: ${appointment['patient']}');
      
      if (appointment['patient'] != null) {
        var patient = appointment['patient'];
        String? patientId = patient['user_id']?.toString();
        String fullName = patient['username'] ?? 'Неизвестный пациент';
        String firstName = patient['first_name'] ?? '';
        String profileImage = patient['photo'] ?? '';
        
        if (patientId != null && patientId != 'null') {
          print('DEBUG: Found patient: $patientId, name: $fullName');
          
          // Check if we've already added this patient
          if (!uniquePatientIds.contains(patientId)) {
            uniquePatientIds.add(patientId);
            patients.add({
              'id': patientId,
              'user_id': patientId, // Добавляем user_id для совместимости
              'full_name': fullName,
              'first_name': firstName,
              'profile_image': profileImage,
            });
            print('DEBUG: Added patient: $fullName');
          } else {
            print('DEBUG: Patient $patientId already exists, skipping');
          }
        } else {
          print('DEBUG: Patient ID is null or invalid');
        }
      } else {
        print('DEBUG: Appointment has no patient data');
      }
    }
    
    // Store patients in a dedicated store (we'll need to create this)
    // For now, we'll store them in the doctors store temporarily
    DoctorsStore storeDoctorsStore = getIt.get<DoctorsStore>();
    storeDoctorsStore.clearDoctorsData();
    
    for (var patient in patients) {
      storeDoctorsStore.addDoctorToDoctorsData(patient);
    }
    
    print('DEBUG: Found ${patients.length} unique patients for doctor $doctorId');
    print('DEBUG: Patients list: $patients');
    print('DEBUG: Doctors store now has ${storeDoctorsStore.doctorsDataList.length} items');
    return true;
  } catch (e) {
    print('DEBUG: Error in patient extraction: $e');
    return false;
  }
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
