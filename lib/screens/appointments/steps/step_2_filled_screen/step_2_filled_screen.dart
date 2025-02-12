import 'dart:convert';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/steps/step_3_filled_screen/step_3_filled_screen.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/spacing.dart';
import '../../../../widgets/custom_icon_button.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

class AppointmentManager {
  final String doctorId;
  DateTime date;
  String formattedDate = '';
  List<dynamic> availableTimes = [];
  int selectedTime = 0;
  ContactMethods contactMethod = ContactMethods.message;

  AppointmentManager({required this.doctorId, required this.date});

  Future<void> fetchTimes() async {
    // Format the date as yyyy-MM-dd
    formattedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    // Simulating fetching data from an API
    String apiUrl =
        'https://onlinedoctor.su/doctor-session-time?adminAppointmentDoctorId=$doctorId&date=$formattedDate&timezone_offset_minutes=180';
    print(apiUrl);
    printLog(apiUrl);
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['data']['slots'];
        availableTimes = jsonResponse;
      } else {
        availableTimes = ['No dates'];
        //  date = formattedDate;
      }
    } catch (e) {
      printLog('Error fetching times: $e');
      availableTimes = ['No dates'];
    }
    printLog(availableTimes);
  }
}

class AppointmentsStep2FilledScreen extends StatefulWidget {
  DateTime date;
  late AppointmentManager appointmentManager;

  AppointmentsStep2FilledScreen({Key? key, required this.date})
      : super(key: key);
  @override
  State<AppointmentsStep2FilledScreen> createState() =>
      _AppointmentsStep2FilledScreenState();
}

enum ContactMethods { message, voiceCall, videoCall }

class _AppointmentsStep2FilledScreenState
    extends State<AppointmentsStep2FilledScreen> {
  late Map<dynamic, dynamic> doctor;
//  late TimeController timeController;
  late AppointmentManager appointmentManager;
  Future<void> _loadData() async {
    await appointmentManager.fetchTimes();
    printLog('loading data...');
    setState(() {
      availableTimesList = appointmentManager.availableTimes;
      formattedDate = appointmentManager.formattedDate;
    });
  }

  @override
  void initState() {
    printLog('initing');
    super.initState();
    doctor = context.selectedDoctor;
    appointmentManager = AppointmentManager(
      doctorId: doctor['doctor_id'],
      date: widget.date,
    );
    appointmentManager.fetchTimes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    super.initState();
  }

  bool isMorning = true;
  int selectedTime = 0;
  ContactMethods contactMethod = ContactMethods.message;

  late List<dynamic> availableTimesList = ['...'];
  late String formattedDate = '...';
  @override
  Widget build(BuildContext context) {
    void _handleRefresh() {
      appointmentManager.fetchTimes();
    }

    Widget _buildContent() {
      return Text("Загрузка...");
      // ... existing content ...
    }

    Widget _buildLoadingIndicator(bool isLoading) {
      if (isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return _buildContent();
    }

//    final timeController = Get.find<TimeController>();
    // appointmentManager.fetchTimes();
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return Scaffold(
      /* appBar: AppBar(title: Text('Available Times'), actions: [
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            appointmentManager.fetchTimes();

            setState(() {
              availableTimesList = appointmentManager.availableTimes;
              printLog('refreshing');
              printLog(widget.date);

//            timeController.fetchTimes();
            });
          },
        ),
      ]),
      // floatingActionButton: FloatingActionButton(onPressed: null, child: Text('doctor id: ${doctor['doctor_id']}')),
      */
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(
                top: 20,
              ),
              child: Padding(
                padding: getPadding(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const BkBtn(),
                    HorizontalSpace(width: 20),
                    Text(
                      "${doctor['username']}", //,//  ${doctor['doctor_id']}",
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
            VerticalSpace(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 14,
                          right: 24,
                        ),
                        child: Text(
                          "Завтра, 02.09.2024",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white
                                : ColorConstant.bluegray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 24,
                        top: 16,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CustomButton(
                            isDark: isDark,
                            width: 184,
                            text: "Morning",
                            onTap: () {
                              setState(() {
                                isMorning = true;
                              });
                            },
                            variant: isMorning
                                ? ButtonVariant.FillBlueA400
                                : ButtonVariant.OutlineBlueA400,
                            shape: ButtonShape.RoundedBorder21,
                            padding: ButtonPadding.PaddingAll12,
                            fontStyle: isMorning
                                ? ButtonFontStyle.SourceSansProSemiBold18
                                : ButtonFontStyle
                                    .SourceSansProSemiBold18BlueA400,
                            prefixWidget: Container(
                              margin: getMargin(
                                  right: isRtl ? 0 : 10, left: isRtl ? 10 : 0),
                              child: Image.asset(
                                ImageConstant.morning,
                                color: isMorning
                                    ? Colors.white
                                    : ColorConstant.blueA400,
                                width: getHorizontalSize(20),
                                height: getVerticalSize(20),
                              ),
                            ),
                          ),
                          HorizontalSpace(width: 12),
                          CustomButton(
                            isDark: isDark,
                            width: 184,
                            text: "Evening",
                            onTap: () {
                              setState(() {
                                isMorning = false;
                              });
                            },
                            variant: isMorning
                                ? ButtonVariant.OutlineBlueA400
                                : ButtonVariant.FillBlueA400,
                            shape: ButtonShape.RoundedBorder21,
                            padding: ButtonPadding.PaddingAll12,
                            fontStyle: isMorning
                                ? ButtonFontStyle
                                    .SourceSansProSemiBold18BlueA400
                                : ButtonFontStyle.SourceSansProSemiBold18,
                            prefixWidget: Container(
                              margin: getMargin(
                                  right: isRtl ? 0 : 10, left: isRtl ? 10 : 0),
                              child: Image.asset(
                                ImageConstant.evening,
                                color: isMorning
                                    ? ColorConstant.blueA400
                                    : Colors.white,
                                width: getHorizontalSize(20),
                                height: getVerticalSize(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 20,
                          top: 20,
                          bottom: 10,
                          right: 20,
                        ),
                        child: Text(
                          "Choose the Hour",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ColorConstant.bluegray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getVerticalSize(240),
                      child: GridView.builder(
                        padding: getPadding(
                          left: 20,
                          top: 10,
                          right: 20,
                        ),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio: 2.767,
                          // mainAxisExtent: getVerticalSize(
                          //   158.00,
                          // ),
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: getHorizontalSize(
                            10.00,
                          ),
                          crossAxisSpacing: getHorizontalSize(
                            10.00,
                          ),
                        ),
                        itemCount: availableTimesList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedTime = index;
                              });
                            },
                            child: Container(
                              padding: getPadding(
                                left: 20,
                                top: 8,
                                right: 20,
                                bottom: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTime == index
                                    ? ColorConstant.blueA400
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    21.50,
                                  ),
                                ),
                                border: Border.all(
                                  color: ColorConstant.blueA400,
                                  width: getHorizontalSize(
                                    2.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                availableTimesList[0] != 'No dates'
                                    ? availableTimesList[index]
                                        .split('-')
                                        .map((e) => e + '\n')
                                        .join()
                                    : 'Свободных мест на \n ${appointmentManager.formattedDate} нет',
                                // availableTimesList[index] +
                                //     '${isMorning ? ' AM' : ' PM'}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedTime == index
                                      ? Colors.white
                                      : ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    17,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 20,
                          top: 20,
                          right: 20,
                        ),
                        child: Text(
                          "Fee Information",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ColorConstant.bluegray800,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    VerticalSpace(height: 14),
                    InkWell(
                      onTap: () {
                        setState(() {
                          contactMethod = ContactMethods.message;
                        });
                      },
                      child: Container(
                        margin: getMargin(
                          top: 8.0,
                          left: 20,
                          right: 20,
                          bottom: 8.0,
                        ),
                        padding: getPadding(
                            left: 20, right: 20, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              16.00,
                            ),
                          ),
                          border: Border.all(
                              color: contactMethod == ContactMethods.message
                                  ? Colors.transparent
                                  : ColorConstant.lightLine),
                          gradient: LinearGradient(
                            begin: const Alignment(
                              1,
                              1.0024292469024658,
                            ),
                            end: const Alignment(
                              0,
                              0.0024292469024658203,
                            ),
                            colors: contactMethod == ContactMethods.message
                                ? [
                                    ColorConstant.blueA400,
                                    ColorConstant.blue300,
                                  ]
                                : [Colors.transparent, Colors.transparent],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomIconButton(
                                  isRtl: isRtl,
                                  height: 56,
                                  width: 56,
                                  variant:
                                      contactMethod == ContactMethods.message
                                          ? IconButtonVariant.FillWhiteA700
                                          : IconButtonVariant.FillBlueA40019,
                                  shape: IconButtonShape.RoundedBorder28,
                                  padding: IconButtonPadding.PaddingAll16,
                                  child: CommonImageView(
                                    imagePath: ImageConstant.reviews,
                                  ),
                                ),
                                HorizontalSpace(width: 16),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Messaging",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: contactMethod ==
                                                ContactMethods.message
                                            ? ColorConstant.whiteA700
                                            : isDark
                                                ? Colors.white
                                                : ColorConstant.black900,
                                        fontSize: getFontSize(
                                          18,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 3,
                                      ),
                                      child: Text(
                                        "Can messaging with doctor",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: contactMethod ==
                                                  ContactMethods.message
                                              ? ColorConstant.whiteA700
                                              : isDark
                                                  ? Colors.white
                                                  : ColorConstant.lightGrayText,
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${Constants.currency}5",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: contactMethod == ContactMethods.message
                                    ? ColorConstant.whiteA700
                                    : ColorConstant.blueA400,
                                fontSize: getFontSize(
                                  23,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          contactMethod = ContactMethods.voiceCall;
                        });
                      },
                      child: Container(
                        margin: getMargin(
                          top: 8.0,
                          left: 20,
                          right: 20,
                          bottom: 8.0,
                        ),
                        padding: getPadding(
                            left: 20, right: 20, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              16.00,
                            ),
                          ),
                          border: Border.all(
                              color: contactMethod == ContactMethods.voiceCall
                                  ? Colors.transparent
                                  : ColorConstant.lightLine),
                          gradient: LinearGradient(
                            begin: const Alignment(
                              1,
                              1.0024292469024658,
                            ),
                            end: const Alignment(
                              0,
                              0.0024292469024658203,
                            ),
                            colors: contactMethod == ContactMethods.voiceCall
                                ? [
                                    ColorConstant.blueA400,
                                    ColorConstant.blue300,
                                  ]
                                : [Colors.transparent, Colors.transparent],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomIconButton(
                                  isRtl: isRtl,
                                  height: 56,
                                  width: 56,
                                  variant:
                                      contactMethod == ContactMethods.voiceCall
                                          ? IconButtonVariant.FillWhiteA700
                                          : IconButtonVariant.FillBlueA40019,
                                  shape: IconButtonShape.RoundedBorder28,
                                  padding: IconButtonPadding.PaddingAll16,
                                  child: CommonImageView(
                                    imagePath: ImageConstant.call,
                                  ),
                                ),
                                HorizontalSpace(width: 16),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Voice Call",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: contactMethod ==
                                                ContactMethods.voiceCall
                                            ? ColorConstant.whiteA700
                                            : isDark
                                                ? Colors.white
                                                : ColorConstant.black900,
                                        fontSize: getFontSize(
                                          18,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 3,
                                      ),
                                      child: Text(
                                        "Can make a voice call with doctor",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: contactMethod ==
                                                  ContactMethods.voiceCall
                                              ? ColorConstant.whiteA700
                                              : isDark
                                                  ? Colors.white
                                                  : ColorConstant.lightGrayText,
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${Constants.currency}10",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: contactMethod == ContactMethods.voiceCall
                                    ? ColorConstant.whiteA700
                                    : ColorConstant.blueA400,
                                fontSize: getFontSize(
                                  23,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          contactMethod = ContactMethods.videoCall;
                        });
                      },
                      child: Container(
                        margin: getMargin(
                          top: 8.0,
                          left: 20,
                          right: 20,
                          bottom: 8.0,
                        ),
                        padding: getPadding(
                            left: 20, right: 20, top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            getHorizontalSize(
                              16.00,
                            ),
                          ),
                          border: Border.all(
                              color: contactMethod == ContactMethods.videoCall
                                  ? Colors.transparent
                                  : ColorConstant.lightLine),
                          gradient: LinearGradient(
                            begin: const Alignment(
                              1,
                              1.0024292469024658,
                            ),
                            end: const Alignment(
                              0,
                              0.0024292469024658203,
                            ),
                            colors: contactMethod == ContactMethods.videoCall
                                ? [
                                    ColorConstant.blueA400,
                                    ColorConstant.blue300,
                                  ]
                                : [Colors.transparent, Colors.transparent],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomIconButton(
                                  isRtl: isRtl,
                                  height: 56,
                                  width: 56,
                                  variant:
                                      contactMethod == ContactMethods.videoCall
                                          ? IconButtonVariant.FillWhiteA700
                                          : IconButtonVariant.FillBlueA40019,
                                  shape: IconButtonShape.RoundedBorder28,
                                  padding: IconButtonPadding.PaddingAll16,
                                  child: CommonImageView(
                                    imagePath: ImageConstant.videocam,
                                  ),
                                ),
                                HorizontalSpace(width: 16),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Video Call",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: contactMethod ==
                                                ContactMethods.videoCall
                                            ? ColorConstant.whiteA700
                                            : isDark
                                                ? Colors.white
                                                : ColorConstant.black900,
                                        fontSize: getFontSize(
                                          18,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 3,
                                      ),
                                      child: Text(
                                        "Can make a video call with doctor",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: contactMethod ==
                                                  ContactMethods.videoCall
                                              ? ColorConstant.whiteA700
                                              : isDark
                                                  ? Colors.white
                                                  : ColorConstant.lightGrayText,
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "${Constants.currency}20",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: contactMethod == ContactMethods.videoCall
                                    ? ColorConstant.whiteA700
                                    : ColorConstant.blueA400,
                                fontSize: getFontSize(
                                  23,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      isDark: isDark,
                      width: size.width,
                      text: "Next",
                      margin: getMargin(
                        left: 20,
                        right: 20,
                        bottom: 10,
                        top: 10,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AppointmentsStep3FilledScreen(
                                    time: availableTimesList[selectedTime],
                                    date: appointmentManager.date,
                                    contactMethod: contactMethod,
                                  )),
                        );
                      },
                      fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
