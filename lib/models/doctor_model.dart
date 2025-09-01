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
      this.description,
      this.qualifications,
      this.schedule,
      this.reviews});

  String? doctorId;
  List<String>? specializations;
  List<dynamic>? qualifications; // Changed to store raw qualification objects
  String? userId;
  String? userName;
  String? firstName;
  String? lastName;
  String? photo;
  String? description;
  List<int>? schedule;
  List<dynamic>? reviews; // Store review objects

  DoctorModel.fromJson(Map json) {
    doctorId = json['doctor_id'];

    // Handle qualifications - store the complete objects
    if (json['doctorUser']?['qualifications'] != null) {
      qualifications = [];
      for (var qual in json['doctorUser']['qualifications']) {
        qualifications!.add({
          '__typename': qual['__typename'] ?? 'Qualification',
          'degree': qual['degree'],
          'university': qual['university'],
          'year': qual['year'],
        });
      }
    } else if (json['qualifications'] != null) {
      // Fallback if qualifications are at root level
      qualifications = [];
      for (var qual in json['qualifications']) {
        qualifications!.add({
          '__typename': qual['__typename'] ?? 'Qualification',
          'degree': qual['degree'],
          'university': qual['university'],
          'year': qual['year'],
        });
      }
    }

    if (json['specializations'] != null) {
      specializations = [];
      json["specializations"].forEach((specializationsElement) {
        specializations!.add(specializationsElement['name']);
      });
    }
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
    description = json['doctorUser']['description'];
    qualifications = json['doctorUser']['qualifications'];
    
    // Handle reviews
    if (json['reviews'] != null) {
      reviews = [];
      for (var review in json['reviews']) {
        reviews!.add({
          'id': review['id'],
          'review': review['review'],
          'rating': review['rating'],
          'created_at': review['created_at'],
          'patient': review['patient'] != null ? {
            'patientUser': review['patient']['patientUser'] != null ? {
              'first_name': review['patient']['patientUser']['first_name'],
              'last_name': review['patient']['patientUser']['last_name'],
            } : null
          } : null
        });
      }
    }
  }

  Map toJson() {
    var specializationsList = [];
    for (var specializationsElement in specializations!) {
      specializationsList.add({
        'name': specializationsElement,
      });
    }
    var days = [];
    if (schedule != null) {
      for (var day in schedule!) {
        days.add({
          'day': day,
        });
      }
    }
    final qualificationsList = (qualifications ?? [])
        .map((qual) => {
              '__typename': qual['__typename'],
              'degree': qual['degree'],
              'university': qual['university'],
              'year': qual['year'],
            })
        .toList();

    final reviewsList = (reviews ?? [])
        .map((review) => {
              'id': review['id'],
              'review': review['review'],
              'rating': review['rating'],
              'created_at': review['created_at'],
              'patient': review['patient'],
            })
        .toList();

    var map = {
      'doctor_id': doctorId,
      'specializations': specializationsList,
      'user_id': userId,
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'photo': photo,
      'description': description,
      'schedule': days,
      'qualifications': qualificationsList,
      'reviews': reviewsList
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
