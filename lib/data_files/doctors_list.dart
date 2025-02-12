import 'package:doctorq/models/doctors_model.dart';

import '../theme/image_constant.dart';

List<DoctorsModel> doctorList = doctors();
List<DoctorsModel> doctors() {
  return [
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor1,
        name: "Dr. Ralph Edwards hello",
        shortSpecialization: 'Cardio Specialist',
        specialization: "Cardio Specialist -  Ramsay College  Hospital"),
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor2,
        name: "Dr. Jane Cooper",
        shortSpecialization: 'Cardio Specialist',
        specialization: "Cardio Specialist -  Nanyang Hospital"),
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor3,
        shortSpecialization: 'Cardio Specialist',
        name: "Dr. Dianne Russell",
        specialization: "Cardio Specialist -  Porcini Spec Hospital"),
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor4,
        shortSpecialization: 'Cardio Specialist',
        name: "Dr. Albert Flores",
        specialization: "Cardio Specialist -  Bracket Medical London Hospital"),
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor5,
        name: "Dr. Darrell Steward",
        shortSpecialization: 'Cardio Specialist',
        specialization: "Cardio Specialist -  Medical London Hospital"),
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor6,
        name: "Dr. Dianne Russell",
        shortSpecialization: 'Cardio Specialist',
        specialization: "Cardio Specialist -  Ramsay College  Hospital"),
    DoctorsModel(
        id: "100",
        img: ImageConstant.doctor7,
        name: "Dr. Ronald Richards",
        shortSpecialization: 'Cardio Specialist',
        specialization: "Cardio Specialist -  Nanyang Hospital"),
  ];
}
