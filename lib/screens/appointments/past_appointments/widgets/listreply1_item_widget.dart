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
import 'package:doctorq/daily/daily_app.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_flutter/daily_flutter.dart' if (dart.library.html) 'package:doctorq/daily/daily_flutter_stub.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_count_down/date_count_down.dart';

// Утилитная функция для проверки истечения комнаты
bool _isRoomExpired(dynamic roomData) {
  if (roomData == null || roomData.toString().isEmpty || roomData.toString() == 'null') {
    return false; // Нет данных о комнате - не истекла
  }
  
  try {
    var roomInfo = jsonDecode(roomData.toString());
    if (roomInfo['config'] != null && roomInfo['config']['exp'] != null) {
      int expTimestamp = roomInfo['config']['exp'];
      DateTime expDate = DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);
      DateTime now = DateTime.now();
      
      print('Room expiration check:');
      print('  Expiration date: ${expDate.toString()}');
      print('  Current date: ${now.toString()}');
      print('  Is expired: ${expDate.isBefore(now)}');
      
      return expDate.isBefore(now);
    }
  } catch (e) {
    print('Error checking room expiration: $e');
  }
  
  return false; // Не удалось проверить - считаем не истекшей
}

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
      // СНАЧАЛА проверяем истечение комнаты
      if (_isRoomExpired(roomData)) {
        print('DEBUG: Room has expired, using test room instead');
        var prefs = await SharedPreferences.getInstance();
        final client = await CallClient.create();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyApp(
              appointment_unique_id: item['appointment_unique_id'],
              room: 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81',
              prefs: prefs,
              callClient: client,
            ),
          ),
        );
        return;
      }
      
      // Room data exists, proceed with navigation
      var roomUrl = jsonDecode(roomData)['url'];
      print('Room URL: $roomUrl');

      var prefs = await SharedPreferences.getInstance();
      final client = await CallClient.create();
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: item['appointment_unique_id'],
            room: roomUrl,
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
            room: 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81',
            prefs: prefs,
            callClient: client,
          ),
        ),
      );
      print("no room");
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
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getAppointmentTimeFrom(item),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: getFontSize(14),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          getAppointmentTimeTo(item),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: getFontSize(14),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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
    // Показываем ровно то, что пришло с бэкенда (уже 24h формат)
    final from = item['from_time']?.toString() ?? '--:--';
    final to = item['to_time']?.toString() ?? '--:--';
    return '$from - $to';
  }

  getAppointmentTimeFrom(item) {
    return item['from_time']?.toString() ?? '--:--';
  }

  getAppointmentTimeTo(item) {
    return item['to_time']?.toString() ?? '--:--';
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
