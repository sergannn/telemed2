import 'dart:developer';

import 'package:doctorq/constant/constants.dart';
import 'package:doctorq/models/doctor_model.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql/client.dart';

Future<bool> getStartupData() async {
  // logOut();

  printLog('Loading startup data');

  await getDoctors();
  await getSpecs();
  printLog('Doctors loaded');

  printLog('Force Logged In State');
  return false;
}
