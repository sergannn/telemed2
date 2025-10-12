import 'package:doctorq/models/doctor_model.dart';

class DoctorSessionModel {
  String? sdoctorSessionsId;
  String? sessionMeetingTime;
  DoctorModel? doctor;
  String? sessionGap;
  List<SessionWeekDay>? sessionWeekDays;

  DoctorSessionModel({
    this.sdoctorSessionsId,
    this.sessionMeetingTime,
    this.doctor,
    this.sessionGap,
    this.sessionWeekDays,
  });

  DoctorSessionModel.fromJson(Map<String, dynamic> json) {
    sdoctorSessionsId = json['id'];
    sessionMeetingTime = json['session_meeting_time'];
    sessionGap = json['session_gap'];
    sessionWeekDays = <SessionWeekDay>[];
    for (int index = 0; index < json['sessionWeekDays'].length; index++) {
      sessionWeekDays!.add(SessionWeekDay.fromJson(json['sessionWeekDays'][index]));
    }
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = sdoctorSessionsId;
    data['session_meeting_time'] = sessionMeetingTime;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['session_gap'] = sessionGap;
    if (sessionWeekDays != null) {
      data['sessionWeekDays'] = sessionWeekDays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SessionWeekDay {
  int? dayOfWeek;
  String? startTime;
  String? startTimeType;
  String? endTime;
  String? endTimeType;

  SessionWeekDay({
    this.dayOfWeek,
    this.startTime,
    this.startTimeType,
    this.endTime,
    this.endTimeType,
  });

  SessionWeekDay.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['day_of_week'];
    startTime = json['start_time'];
    startTimeType = json['start_time_type'];
    endTime = json['end_time'];
    endTimeType = json['end_time_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day_of_week'] = dayOfWeek;
    data['start_time'] = startTime;
    data['start_time_type'] = startTimeType;
    data['end_time'] = endTime;
    data['end_time_type'] = endTimeType;
    return data;
  }
}
