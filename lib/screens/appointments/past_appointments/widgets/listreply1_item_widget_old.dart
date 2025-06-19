import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/list/messaging_screen/messaging_screen.dart';
import 'package:doctorq/screens/appointments/list/video_call_screen/video_call_screen.dart';
import 'package:doctorq/screens/appointments/list/voice_call_screen/voice_call_screen.dart';
import 'package:doctorq/screens/ser_view.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:doctorq/data_files/appointments_lists.dart';
import 'package:doctorq/daily/main.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
//import 'package:daily_flutter/daily_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_count_down/date_count_down.dart';

class AppointmentListItem extends StatelessWidget {
  final int index;
  final Map<dynamic, dynamic> item;

  const AppointmentListItem({Key? key, required this.index, required this.item})
      : super(key: key);
  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<bool> checkPermissions() async {
    return await Permission.camera.isGranted &&
        await Permission.microphone.isGranted;
  }

  navigateToScreen(BuildContext context) async {
    print('заходим в комнату');
    print(item);
    var room_url = jsonDecode(item['room_data'])['url'];
    print(room_url);
    /*  var prefs = await SharedPreferences.getInstance();
    final client = await CallClient.create();
    //await prefs.setString(
    //    item['d21ec1e9-8004-11ef-a4b8-02420a000404'], room_url);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyApp(
          appointment_unique_id: item['appointment_unique_id'],
          room: 'https://ser-tele-med.daily.co/test_room', //room_url,
          prefs: prefs,
          callClient: client,
        ),
      ),
    );*/
  }

  void navigateToScreenWithTypes(BuildContext context) async {
    print("Navigating...");

    try {
      // Check if item exists
      if (item == null || item["description"] == null) {
        print("Error: item or description is null");
        return;
      }

      String description = item["description"];

      switch (description) {
        case "ContactMethods.voiceCall":
          print("voice");
          break;
        case "ContactMethods.videoCall":
          try {
            /* var prefs = await SharedPreferences.getInstance();
            final client = await CallClient.create();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyApp(
                  appointment_unique_id: item['appointment_unique_id'],
                  room: item['room_data'],
                  prefs: prefs,
                  callClient: client,
                ),
              ),
            );*/
          } catch (e) {
            print('Error during video call setup: $e');
            // Optionally show an error message to the user here
          }
          break;
        default:
          print('Unknown navigation option: $description');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
      // Optionally show an error message to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("__");
    //print(item);
    //print("it was item");
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    bool doctor = false;

    List<Map<dynamic, dynamic>> appointmentsList = context.appointmentsData;

    return InkWell(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          12.00,
        ),
      ),
      onDoubleTap: () async {
        await requestPermissions();
        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.microphone,
        ].request();

        print("Permission statuses:");
        for (var entry in statuses.entries) {
          print("${entry.key}: ${entry.value}");
        }

        bool hasCameraPermission = await Permission.camera.isGranted;
        bool hasMicrophonePermission = await Permission.microphone.isGranted;

        print("Has Camera Permission: $hasCameraPermission");
        print("Has Microphone Permission: $hasMicrophonePermission");

        print(hasCameraPermission && hasMicrophonePermission
            ? "Both permissions granted"
            : "One or both permissions denied");

        bool hasPermission = await checkPermissions();
        print(hasPermission ? "Permissions granted" : "Permissions denied");

        if (hasPermission) {
          print("navigating");
          navigateToScreen(context);
        } else {
          print("not okey");
          // Request permissions
        }
/*
        if (item["description"] == "ContactMethods.voiceCall") {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AppointmentsListMessagingScreen(
                  appointment: upcommingList[2])));
        } else if (item["description"] == "ContactMethods.videoCall") {
            final client = await CallClient.create();

              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (contect) =>
                       DailyApp(prefs: prefs, callClient: client)));
          builder: (context) => SerView(
                  doctorId: '1',
                  user: context.userData['user_id'],
                  doctor: doctor)));
        } else {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => SerView(
                  doctorId: '1',
                  user: context.userData['user_id'],
                  doctor: doctor)));

          //        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => AppointmentsListVoiceCallScreen(user: context.userData['user_id'], appointment: upcommingList[2])));
        }*/
      },
      child: Container(
        // height: getVerticalSize(100),
        margin: getMargin(top: 8.0, bottom: 8.0, right: 20, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(12.00),
          ),
          border: Border.all(
            color: isDark ? ColorConstant.darkLine : ColorConstant.bluegray50,
            width: getHorizontalSize(1.00),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: getSize(100.00),
              width: getSize(100.00),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: isRtl
                            ? Radius.circular(getHorizontalSize(0.00))
                            : Radius.circular(getHorizontalSize(12.00)),
                        bottomLeft: isRtl
                            ? Radius.circular(getHorizontalSize(0.00))
                            : Radius.circular(getHorizontalSize(12.00)),
                        bottomRight: isRtl
                            ? Radius.circular(getHorizontalSize(12.00))
                            : Radius.circular(getHorizontalSize(0.00)),
                        topRight: isRtl
                            ? Radius.circular(getHorizontalSize(12.00))
                            : Radius.circular(getHorizontalSize(0.00)),
                      ),
                      child: CommonImageView(
                        url: item["doctor"]["photo"],
                        height: getSize(
                          100.00,
                        ),
                        width: getSize(
                          100.00,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomIconButton(
                    isRtl: isRtl,
                    height: 36,
                    width: 36,
                    margin: getMargin(
                      top: 10,
                    ),
                    variant: IconButtonVariant.OutlineIndigoA20014_1,
                    shape: IconButtonShape.CustomBorderTL12,
                    alignment:
                        isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
                    child: Image.asset(getImagePathByContactMethod(item),
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            HorizontalSpace(width: 20),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 2, // Allow up to 2 lines
                            item["doctor"]["username"] +
                                "\nvs " +
                                item['patient']['username'],
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: getFontSize(
                                16,
                              ),
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                /*Padding(
                                  padding: getPadding(bottom: 1),
                                  child: Text(
                                    getContactMethod(item),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: getFontSize(11),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),*/
                                /*   Padding(
                                  padding: getPadding(left: 4, top: 1),
                                  child: Text(
                                    "-",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: getFontSize(
                                        11,
                                      ),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),*/
                                /* Padding(
                                  padding: getPadding(
                                    left: 4,
                                    bottom: 1,
                                  ),
                                  child: Text(
                                    getAppointmentStatus(item),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: ColorConstant.indigo601,
                                      fontSize: getFontSize(11),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: getPadding(top: 3),
                            child: Text(
                              getAppointmentTime(item),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: getFontSize(14),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CountDownText(
                            due: DateTime.parse(item["date"]),
                            finishedText: ' Done',
//                                DateTime.parse(item["date"]).toString(),
                            showLabel: true,
                            longDateName: false,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: getMargin(
                          left: isRtl ? 20 : 0, right: isRtl ? 0 : 20),
                      padding: getPadding(all: 10),
                      height: getVerticalSize(44),
                      width: getHorizontalSize(44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorConstant.blueA400.withOpacity(0.1),
                      ),
                      child: CommonImageView(
                        imagePath: getImagePathByContactMethod(
                            appointmentsList[index]),
                      ),
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

  getContactMethod(Map item) {
    if (item["description"] == "ContactMethods.voiceCall") {
      return 'Voice Call';
    }
    if (item["description"] == "ContactMethods.videoCall") {
      return 'Video Call';
    }
    if (item["description"] == "ContactMethods.message") {
      return 'Message';
    }
    return 'N/A';
  }

  getAppointmentStatus(item) {
    if (item["status"] == "1") {
      return 'Upcoming..';
    }
    if (item["status"] == "2") {
      return 'Completed';
    }
    if (item["status"] == "3") {
      return 'Cancelled';
    }
    return 'N/A';
  }

  getAppointmentTime(item) {
    return item['from_time'] +
        ' ' +
        item['from_time_type'] +
        " - " +
        item['to_time'] +
        ' ' +
        item['to_time_type'];
  }
}

getImagePathByContactMethod(Map<dynamic, dynamic> item) {
  if (item["description"] == "ContactMethods.videoCall") {
    return ImageConstant.videocam;
  }

  if (item["description"] == "ContactMethods.voiceCall") {
    return ImageConstant.call;
  }

  if (item["description"] == "ContactMethods.message") {
    return ImageConstant.reviews;
  }

  return ImageConstant.empty;
}
