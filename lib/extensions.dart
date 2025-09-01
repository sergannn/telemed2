import 'dart:developer';

import 'package:doctorq/models/doctor_session_model.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/stores/doctor_sessions_store.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/stores/patients_store.dart';
import 'package:doctorq/stores/user_store.dart';

import 'package:doctorq/stores/specs_store.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

extension BuildContextExt on BuildContext {
  static DoctorsStore storeDoctorsStore = getIt.get<DoctorsStore>();
  static SpecsStore storeSpecsStore = getIt.get<SpecsStore>();
  static UserStore storeUserStore = getIt.get<UserStore>();
  static AppointmentsStore storeAppointmentsStore =
      getIt.get<AppointmentsStore>();
  static DoctorSessionsStore storeDoctorSessionsStore =
      getIt.get<DoctorSessionsStore>();
  static PatientsStore storePatientsStore = getIt.get<PatientsStore>();

  // All about user
  Map<dynamic, dynamic> get userData {
    //   UserStore storeUserStore = getIt.get<UserStore>();
    return storeUserStore.userData;
  }

  // All about doctors
  List get doctorsData {
    return storeDoctorsStore.doctorsDataList;
  }

  // All about specs
  List get specsData {
    return storeSpecsStore.specsDataList;
  }

  void setSelectedDoctorByIndex(int index) {
    print('setSelectedDoctorByIndex');
    print(storeDoctorsStore.doctorsDataList[index]);
    storeDoctorsStore
        .setSelectedDoctor(storeDoctorsStore.doctorsDataList[index]);
  }

  Map<dynamic, dynamic> get selectedDoctor {
    return storeDoctorsStore.selectedDoctor;
  }

  // All about patients
  List get patientsData {
    return storePatientsStore.patientsDataList;
  }

  void setSelectedPatientByIndex(int index) {
    print('setSelectedPatientByIndex');
    print(storePatientsStore.patientsDataList[index]);
    storePatientsStore
        .setSelectedPatient(storePatientsStore.patientsDataList[index]);
  }

  Map<dynamic, dynamic> get selectedPatient {
    return storePatientsStore.selectedPatient;
  }

  // All about appointments
  List<Map<dynamic, dynamic>> get appointmentsData {
    return storeAppointmentsStore.appointmentsDataList;
  }

  void setSelectedAppointmentByIndex(int index) {
    storeAppointmentsStore.setSelectedAppointment(
        storeAppointmentsStore.appointmentsDataList[index]);
  }

  Map<dynamic, dynamic> get selectedAppointment {
    return storeAppointmentsStore.selectedAppointment;
  }

  // All about doctorSessions
  List<Map<dynamic, dynamic>> get doctorSessionsData {
    return storeDoctorSessionsStore.doctorSessionsDataList;
  }

  void setdoctorSessionsData(Map<String, dynamic> data) {
    storeDoctorSessionsStore.clearDoctorSessionsData();
    DoctorSessionModel sessionModel = DoctorSessionModel.fromJson(data);
    storeDoctorSessionsStore
        .addDoctorSessionToDoctorSessionsData(sessionModel.toJson());
  }

  void setUserData(Map<dynamic, dynamic> data) {
    //storeUserStore.c();
    UserModel userModel = UserModel.fromJson(data);
    storeUserStore.setUserData(userModel.toJson());
//        .addDoctorSessionToDoctorSessionsData(sessionModel.toJson());
  }

  // Calculate duration between two time strings in format "HH:MM"
  int calculateDuration(String? fromTime, String? toTime) {
    if (fromTime == null || toTime == null) return 45;
    
    try {
      final fromParts = fromTime.split(':');
      final toParts = toTime.split(':');
      
      final fromHour = int.parse(fromParts[0]);
      final fromMinute = int.parse(fromParts[1]);
      final toHour = int.parse(toParts[0]);
      final toMinute = int.parse(toParts[1]);
      
      final fromTotalMinutes = fromHour * 60 + fromMinute;
      final toTotalMinutes = toHour * 60 + toMinute;
      
      return toTotalMinutes - fromTotalMinutes;
    } catch (e) {
      return 45; // Default duration if parsing fails
    }
  }
}
