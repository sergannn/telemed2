import 'dart:developer';

import 'package:doctorq/models/doctor_model.dart';
import 'package:doctorq/models/patient_model.dart';

class AppointmentModel {
  AppointmentModel(
      {this.appointmentId,
      this.appointmentUniqueId,
      this.doctor,
      this.description,
      this.status,
      this.date,
      this.fromTime,
      this.fromTimeType,
      this.toTime,
      this.toTimeType,
      this.room_data});

  String? appointmentId;
  String? appointmentUniqueId;
  DoctorModel? doctor;
  PatientModel? patient;
  String? description;
  String? status;
  String? date;
  String? fromTime;
  String? fromTimeType;
  String? toTime;
  String? toTimeType;
  String? room_data;

  AppointmentModel.fromJson(Map json) {
    print("DEBUG: AppointmentModel.fromJson - Starting");
    appointmentId = json['id'];
    appointmentUniqueId = json['appointment_unique_id'];
    
    print("DEBUG: AppointmentModel.fromJson - Creating doctor");
    doctor = json['doctor'] != null 
        ? DoctorModel.fromJson(json['doctor'])
        : DoctorModel();
    print("DEBUG: AppointmentModel.fromJson - Doctor created");
    
    print("DEBUG: AppointmentModel.fromJson - Creating patient");
    patient = json['patient'] != null && json['patient']['patientUser'] != null 
        ? PatientModel.fromJson(json['patient']['patientUser'])
        : PatientModel();
    print("DEBUG: AppointmentModel.fromJson - Patient created");

    description = json['description'];
    status = json['status'];
    date = json['date'];
    fromTime = json['from_time'];
    fromTimeType = json['from_time_type'];
    toTime = json['to_time'];
    toTimeType = json['to_time_type'];
    room_data = json['room_data'];
  }

  Map toJson() {
    var map = {
      'id': appointmentId,
      'appointment_unique_id': appointmentUniqueId,
      'doctor': doctor?.toJson(),
      'patient': patient?.toJson(),
      'description': description,
      'status': status,
      'date': date,
      'from_time': fromTime,
      'from_time_type': fromTimeType,
      'to_time': toTime,
      'to_time_type': toTimeType,
      'room_data': room_data
    };

    return map;
  }
}

// class UserRole {
//   String? name;

//   UserRole({
//     this.name,
//   });

//   Map toJson() => {
//         'name': name,
//       };

//   UserRole.fromJson(Map json) : name = json['name'];

//   @override
//   String toString() {
//     return 'UserRole{ name: $name }';
//   }
// }
