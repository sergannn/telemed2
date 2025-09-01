import 'dart:convert';
import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/stores/doctor_sessions_store.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_switch.dart';
import 'package:doctorq/widgets/custom_text_form_field.dart';
import 'package:doctorq/widgets/loading_overlay.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ScheduleSettingsScreen extends StatefulWidget {
  const ScheduleSettingsScreen({super.key});

  @override
  State<ScheduleSettingsScreen> createState() =>
      _ProfileSettingsAppearanceScreenState();
}

class _ProfileSettingsAppearanceScreenState
    extends State<ScheduleSettingsScreen> {
  late Map<dynamic, dynamic> doctor;
  late List<dynamic> availableTimesList = ['...'];
  late String formattedDate = '...';
  bool switchVal2 = true;
  bool switchVal3 = true;
  int selectedTime = 0;
  TimeOfDay? d1;
  TimeOfDay? d2;
  TimeOfDay? d3;
  TimeOfDay? d4;
  TimeOfDay? d5;
  TimeOfDay? d6;
  TimeOfDay? d7;

  List myDoctorSessions = [];

  List<String> daysOfWeek = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];
  List<int> daysOfWeekActive = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  List<String> daysOfWeekStartTime = [
    "06:00",
    "06:00",
    "06:00",
    "06:00",
    "06:00",
    "06:00",
    "06:00",
  ];
  List<String> daysOfWeekStartTimeType = [
    "*",
    "*",
    "*",
    "*",
    "*",
    "*",
    "*",
  ];
  List<String> daysOfWeekEndTime = [
    "19:00",
    "19:00",
    "19:00",
    "19:00",
    "19:00",
    "19:00",
    "19:00",
  ];
  List<String> daysOfWeekEndTimeType = [
    "*",
    "*",
    "*",
    "*",
    "*",
    "*",
    "*",
  ];

  TextEditingController sessionMeetingTime = TextEditingController();
  TextEditingController sessionGap = TextEditingController();

  @override
  void initState() {
    super.initState();
    printLog('initing');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    printLog('loading data....');
    printLog('Getting Doctor Sessions');

    Future.delayed(Duration.zero, () {
      //  MyOverlay.show(context);
    });

    doctor = context.userData;
    printLog(doctor);

    // пример того как грузить много данных
    await getSessionsD(doctorId: doctor['doctor_id']);
    var sessionWeekDays;
    if (context.doctorSessionsData.length == 0) {
      await getSessionsD(doctorId: '1');
    }
    sessionMeetingTime.text =
        context.doctorSessionsData[0]['session_meeting_time'];
    sessionGap.text = context.doctorSessionsData[0]['session_gap'];

    sessionWeekDays = context.doctorSessionsData[0]['sessionWeekDays'];
    for (var i = 0; i < sessionWeekDays.length; i++) {
      Map<String, dynamic> item = sessionWeekDays[i];
      for (var j = 1; j < daysOfWeek.length; j++) {
        if (item['day_of_week'] == j) {
          daysOfWeekActive[j - 1] = 1;
          daysOfWeekStartTime[j - 1] = item['start_time'];
          daysOfWeekStartTimeType[j - 1] = item['start_time_type'];
          daysOfWeekEndTime[j - 1] = item['end_time'];
          daysOfWeekEndTimeType[j - 1] = item['end_time_type'];
        }
      }
    }

    setState(() {
      myDoctorSessions = context.doctorSessionsData;
    });

    printLog(' Doctor Sessions loaded');

//    MyOverlay.hide();
  }

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (myDoctorSessions.isEmpty) {
      return const Text('Loading...');
    }

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(
                top: 36,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BkBtn(),
                    HorizontalSpace(width: 20),
                    Text(
                      "Настройки расписания",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getFontSize(
                          26,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: getMargin(
                left: 24,
                top: 24,
                right: 24,
              ),
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            2.00,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InputLabel(
                              labelText: "Длина приема в минутах",
                              isDark: isDark),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: isDark
                                    ? customDarkBoxShadow
                                    : customBoxShadow),
                            child: CustomTextFormField(
                              controller: sessionMeetingTime,
                              isDark: isDark,
                              width: 380,
                              focusNode: FocusNode(),
                              hintText:
                                  "Сколько будет длиться каждый прием пациента",
                              margin: getMargin(
                                top: 11,
                              ),
                              shape: TextFormFieldShape.RoundedBorder16,
                              padding: TextFormFieldPadding.PaddingAll18,
                              fontStyle: TextFormFieldFontStyle
                                  .SourceSansProSemiBold16Gray900a2,
                              textInputAction: TextInputAction.done,
                              alignment: Alignment.centerLeft,
                              suffix: CommonImageView(
                                svgPath: ImageConstant.imgSearch,
                              ),
                              suffixConstraints: BoxConstraints(
                                minWidth: getHorizontalSize(
                                  6.00,
                                ),
                                minHeight: getVerticalSize(
                                  6.00,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: getMargin(
                left: 24,
                top: 24,
                right: 24,
              ),
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            2.00,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InputLabel(
                              labelText: "Длина перерыва между приемами",
                              isDark: isDark),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: isDark
                                    ? customDarkBoxShadow
                                    : customBoxShadow),
                            child: CustomTextFormField(
                              controller: sessionGap,
                              isDark: isDark,
                              width: 380,
                              focusNode: FocusNode(),
                              hintText: "Промежуток между сеансами",
                              margin: getMargin(
                                top: 11,
                              ),
                              shape: TextFormFieldShape.RoundedBorder16,
                              padding: TextFormFieldPadding.PaddingAll18,
                              fontStyle: TextFormFieldFontStyle
                                  .SourceSansProSemiBold16Gray900a2,
                              textInputAction: TextInputAction.done,
                              alignment: Alignment.centerLeft,
                              suffix: CommonImageView(
                                svgPath: ImageConstant.imgSearch,
                              ),
                              suffixConstraints: BoxConstraints(
                                minWidth: getHorizontalSize(
                                  6.00,
                                ),
                                minHeight: getVerticalSize(
                                  6.00,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...List<Widget>.generate(daysOfWeek.length, (index) {
              return Row(children: [
                Checkbox(
                    value: daysOfWeekActive[index] == 1,
                    onChanged: (val) {
                      setState(
                        () {
                          print('changed checkbox');
                          print(val);
                          print(index);
                          daysOfWeekActive[index] = val! ? 1 : 0;
                        },
                      );
                    }),
                const SizedBox(width: 8),
                Container(width: 100, child: Text("${daysOfWeek[index]}: ")),
                TextButton(
                  onPressed: () async {
                    final TimeOfDay? timePicked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    DateTime tempDate = DateFormat("HH:mm")
                        .parse("${timePicked!.hour}:${timePicked.minute}");
                    var dateFormat1 = DateFormat("HH:mm");
                    var dateFormat2 = DateFormat("a");
                    setState(
                      () {
                        daysOfWeekStartTime[index] =
                            dateFormat1.format(tempDate);
                        daysOfWeekStartTimeType[index] =
                            dateFormat2.format(tempDate);
                      },
                    );
                  },
                  child: Text(
                    daysOfWeekStartTime[index] != "*"
                        ? "с ${daysOfWeekStartTime[index]}" //${daysOfWeekStartTimeType[index]}"
                        : "",
                  ),
                ),
                if (daysOfWeekStartTime[index] != "*") Text(" \u2014 "),
                TextButton(
                  onPressed: () async {
                    final TimeOfDay? timePicked0 = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    DateTime tempDate = DateFormat("HH:mm")
                        .parse("${timePicked0!.hour}:${timePicked0.minute}");
                    var dateFormat1 = DateFormat("HH:mm");
                    var dateFormat2 = DateFormat("a");
                    setState(
                      () {
                        daysOfWeekEndTime[index] = dateFormat1.format(tempDate);
                        daysOfWeekEndTimeType[index] =
                            dateFormat2.format(tempDate);
                      },
                    );
                  },
                  child: Text(
                    daysOfWeekStartTime[index] != "*"
                        ? "${daysOfWeekEndTime[index]}" //${daysOfWeekEndTimeType[index]}"
                        : "",
                  ),
                ),
              ]);
            }),
            CustomButton(
              variant: ButtonVariant.FillBlueA400,
              isDark: isDark,
              width: size.width,
              text: "Сохранить",
              margin: getMargin(
                left: 24,
                top: 25,
                right: 24,
                bottom: 20,
              ),
              onTap: () async {
                printLog(context.doctorSessionsData[0]);

                Map<String, dynamic> newDoctorSessionData = {
                  "session_meeting_time": sessionMeetingTime.text,
                  "session_gap": sessionGap.text,
                  "sessionWeekDays": []
                };

                for (var i = 0; i < daysOfWeekActive.length; i++) {
                  if (daysOfWeekActive[i] == 0) continue;

                  newDoctorSessionData['sessionWeekDays'].add({
                    "day_of_week": i + 1,
                    "start_time": daysOfWeekStartTime[i],
                    "start_time_type": daysOfWeekStartTimeType[i],
                    "end_time": daysOfWeekEndTime[i],
                    "end_time_type": daysOfWeekEndTimeType[i],
                  });
                }

                context.setdoctorSessionsData(newDoctorSessionData);
                await setSessionsD(doctorId: doctor['doctor_id']);
                snackBar(context, message: 'Изменения сохранены');
              },
              fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
            ),
          ],
        ),
      ),
    ));
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.labelText,
    required this.isDark,
  });

  final String labelText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: getPadding(
          left: 24,
          top: 1,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: getPadding(
                top: 3,
              ),
              child: Text(
                labelText,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: isDark ? Colors.white : ColorConstant.gray900A2,
                  fontSize: getFontSize(
                    16,
                  ),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Asterisk(),
          ],
        ),
      ),
    );
  }
}

class Asterisk extends StatelessWidget {
  const Asterisk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        bottom: 5,
      ),
      child: Text(
        "*",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: ColorConstant.redA700A2,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
