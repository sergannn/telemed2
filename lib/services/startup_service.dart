import 'dart:developer';

import 'package:doctorq/constant/constants.dart';
import 'package:doctorq/models/doctor_model.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/notification_service.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

Future<bool> getStartupData() async {
  // logOut();

  printLog('Loading startup data');

  await getDoctors();
  await getSpecs();
  printLog('Doctors loaded');

  printLog('Force Logged In State');
  await _initializeNotificationService();
  return false;
}

Future<void> _initializeNotificationService() async {
  try {
    final notificationService = GetIt.instance.get<NotificationService>();
    await notificationService.initialize();
    printLog('Notification service initialized');
    print("x");
    // Start checking for new appointments if user is a doctor
    final userStore = GetIt.instance.get<UserStore>();
    if (userStore.userData != null && userStore.userData!['role'] == 'doctor') {
      final doctorId = userStore.userData!['user_id'].toString();
      await notificationService.startCheckingForNewAppointments(doctorId);
      printLog('Started appointment checking for doctor: $doctorId');
    }
    else {print("no..");}
  } catch (e) {
    printLog('Error initializing notification service: $e');
  }
}