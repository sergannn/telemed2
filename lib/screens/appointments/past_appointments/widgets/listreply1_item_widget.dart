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
import 'package:daily_flutter/daily_flutter.dart';
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
    print(item['room_data']);
    dynamic roomData = item['room_data'];
    if (roomData != null && roomData.isNotEmpty) {
      // Room data exists, proceed with navigation
      var roomUrl = jsonDecode(roomData)['url'];
      print('Room URL: $roomUrl');

      var room_url = jsonDecode(item['room_data'])['url'];
      print(room_url);
      var prefs = await SharedPreferences.getInstance();
      final client = await CallClient.create();
      //await prefs.setString(
      //    item['d21ec1e9-8004-11ef-a4b8-02420a000404'], room_url);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: item['appointment_unique_id'],
            room: room_url,
            prefs: prefs,
            callClient: client,
          ),
        ),
      );
    } else {
      var prefs = await SharedPreferences.getInstance();
      final client = await CallClient.create();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: item['appointment_unique_id'],
            room: 'https://telemed2.daily.co/test_room',
            prefs: prefs,
            callClient: client,
          ),
        ),
      );
      print("no room");

      //https://telemed2.daily.co/test_room
    }
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
            var prefs = await SharedPreferences.getInstance();
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
            );
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    bool doctor = false;

    List<Map<dynamic, dynamic>> appointmentsList = context.appointmentsData;
    print(item['doctor']);
    return InkWell(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          12.00,
        ),
      ),
      onTap: () async {
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
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        item["doctor"]["photo"],
                      ),
                      radius: 100,
                    ),
                  ),
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(getImagePathByContactMethod(item),
                          color: ColorConstant.fromHex("81AEEA"))),
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
                                "\n" +
                          item['doctor']['specializations'].isNotEmpty ? 
                             item['doctor']['specializations'][0]['name'] : "",
//                                item['patient']['username'],
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

                          /*  CountDownText(
                            due: DateTime.parse(item["date"]),
                            finishedText: ' Done',
//                                DateTime.parse(item["date"]).toString(),
                            showLabel: true,
                            longDateName: false,
                            style: TextStyle(color: Colors.blue),
                          ),*/
                        ],
                      ),
                    ),
                    Container(
                        child: Text(
                      getAppointmentTime(item),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getFontSize(14),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
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

  String convertTo24Hour(String time, String timeType) {
    // Split time into hours and minutes
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Convert to 24-hour format
    if (timeType == 'PM' && hours != 12) {
      hours += 12;
    } else if (timeType == 'AM' && hours == 12) {
      hours = 0;
    }

    // Format with leading zeros
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  getAppointmentTime(item) {
    String fromTime = item['from_time'];
    String toTime = item['to_time'];

    // Convert to 24-hour format
    String from24Hour = convertTo24Hour(fromTime, item['from_time_type']);
    String to24Hour = convertTo24Hour(toTime, item['to_time_type']);

    // Return in Russian format (00-00 - 24-00)
    return '$from24Hour - $to24Hour';
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
    return Icons.video_call;
    ImageConstant.videocam;
  }

  if (item["description"] == "ContactMethods.voiceCall") {
    return Icons.voice_chat;
    return ImageConstant.call;
  }

  if (item["description"] == "ContactMethods.message") {
    return Icons.message;
    return ImageConstant.reviews;
  }

  return ImageConstant.empty;
}
