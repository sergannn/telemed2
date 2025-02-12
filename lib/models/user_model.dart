class UserModel {
  // TODO add refreshToken
  UserModel({
    this.userId,
    this.patientId,
    this.doctorId,
    this.userName,
    this.firstName,
    this.email,
    this.lastName,
    this.photo,
    this.authToken,
  });

  UserModel.fromJson(Map json) {
    authToken = json['token'];
    userId = json['user']['user_id'];
    patientId = json['user']['patient_id'];
    doctorId = json['user']['doctor_id'];
    userName = json['user']['username'];
    firstName = json['user']['first_name'];
    email = json['user']['email'];

    lastName = json['user']['last_name'];
    photo = json['user']['photo'];

    // if (json['user']['role'] != null &&
    //     !json['user']["role"]['nodes'].isEmpty) {
    //   role = [];
    //   json['user']["role"]['nodes'].forEach((roleElement) {
    //     role!.add(roleElement['name']);
    //   });
    // }
  }

  String? userId;
  String? patientId;
  String? doctorId;
  String? userName;
  String? firstName;
  String? email;
  String? lastName;
  String? photo;
  String? authToken;

  // List<String>? role;

  Map toJson() {
    // final roles = [];
    // role!.forEach((roleElement) {
    //   roles.add({
    //     'name': roleElement,
    //   });
    // });
    return {
      'authToken': authToken, // TODO проверить что прилетает
      'user_id': userId,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'username': userName,
      'first_name': firstName,
      'email': email,
      'last_name': lastName,
      'photo': photo,
    };
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
