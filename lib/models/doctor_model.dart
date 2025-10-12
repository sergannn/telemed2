import 'dart:developer';

class DoctorModel {
  DoctorModel(
      {this.doctorId,
      this.specializations,
      this.userId,
      this.userName,
      this.firstName,
      this.lastName,
      this.photo,
      this.schedule});

  String? doctorId;
  List<String>? specializations;
  String? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? photo;
  List<int>? schedule;

  DoctorModel.fromJson(Map json) {
    print("DEBUG: DoctorModel.fromJson - Starting with json: $json");
    doctorId = json['doctor_id'];

    if (json['specializations'] != null) {
      specializations = [];
      json["specializations"].forEach((specializationsElement) {
        specializations!.add(specializationsElement['name']);
      });
    }
    print("DEBUG: DoctorModel.fromJson - Specializations processed");
    if (json['doctorSession'] != null && json['doctorSession'].length != 0) {
      schedule = [];
      //print(json['doctorSession'][0]["sessionWeekDays"]);
      //  print("__");
      json["doctorSession"][0]["sessionWeekDays"].forEach((wd) {
        //    print(wd);
        //   print("wd");
        if (wd["start_time"] != '*') schedule!.add(wd["day_of_week"]);
      });
    }
//    print(json['doctor_id']);
//    print(json['doctorUser']['user_id']);
    userId = json['doctorUser']['user_id'];
    userName = json['doctorUser']['username'];
    firstName = json['doctorUser']['first_name'];
    lastName = json['doctorUser']['last_name'];
    photo = json['doctorUser']['photo'];
    print("DEBUG: DoctorModel.fromJson - Completed");
  }

  Map toJson() {
    var specializationsList = [];
    if (specializations != null) {
      for (var specializationsElement in specializations!) {
        specializationsList.add({
          'name': specializationsElement,
        });
      }
    }
    var days = [];
    if (schedule != null) {
      for (var day in schedule!) {
        days.add({
          'day': day,
        });
      }
    }
    var map = {
      'doctor_id': doctorId,
      'specializations': specializationsList,
      'user_id': userId,
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'photo': photo,
      'schedule': days
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
