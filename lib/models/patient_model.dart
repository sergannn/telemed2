import 'dart:developer';

class PatientModel {
  PatientModel({
    this.patientId,
    this.specializations,
    this.userId,
    this.userName,
    this.firstName,
    this.lastName,
    this.photo,
  });

  String? patientId;
  List<String>? specializations;
  String? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? photo;

  PatientModel.fromJson(Map json) {
    patientId = json['doctor_id'];

    userId = json['id']?.toString();
    userName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    photo = json['profile_image'];
  }

  Map toJson() {
    var map = {
      'patient_id': patientId,
//      'specializations': specializationsList,
      'user_id': userId,
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'photo': photo,
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
