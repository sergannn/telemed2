import 'dart:math';

import 'package:doctorq/app_export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SpecialistModel {
  final String img;
  final String name;
  final String noOfDoctors;

  SpecialistModel({
    required this.img,
    required this.name,
    required this.noOfDoctors,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    var specialistImages = [
      'assets/images/specialist2.svg',
      'assets/images/specialist3.svg',
      'assets/images/specialist4.svg',
      'assets/images/specialist5.svg',
      'assets/images/specialist6.svg'
    ];
    return SpecialistModel(
      img: specialistImages[Random().nextInt(5)],
      name: json['name'] ?? 'a',
      noOfDoctors: json['noOfDoctors'] ?? Random().nextInt(100).toString(),
    );
  }
}

Future<List<SpecialistModel>> fetchSpecialists() async {
  final response =
      await http.get(Uri.parse('https://admin.onlinedoctor.su/api/specializations'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((item) => SpecialistModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load specialists');
  }
}

List<SpecialistModel> specialistList = [
  SpecialistModel(
      img: ImageConstant.specialist1,
      name: "Cardio Specialist",
      noOfDoctors: "252"),
  SpecialistModel(
      img: ImageConstant.specialist2,
      name: "Dental Specialist",
      noOfDoctors: "186"),
  SpecialistModel(
      img: ImageConstant.specialist3,
      name: "Eye Specialist",
      noOfDoctors: "201"),
  SpecialistModel(
      img: ImageConstant.specialist4,
      name: "Brain Specialist",
      noOfDoctors: "201"),
  SpecialistModel(
      img: ImageConstant.specialist5,
      name: "Mouth Specialist",
      noOfDoctors: "281"),
  SpecialistModel(
      img: ImageConstant.specialist6,
      name: "Child Specialist",
      noOfDoctors: "198"),
  SpecialistModel(
      img: ImageConstant.specialist7,
      name: "Nerve Specialist",
      noOfDoctors: "178"),
  SpecialistModel(
      img: ImageConstant.specialist8,
      name: "Sex Specialist",
      noOfDoctors: "145"),
];
