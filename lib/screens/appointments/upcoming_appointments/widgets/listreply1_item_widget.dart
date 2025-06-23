import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/chat/chat_screen.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/models/appointment_model.dart';
import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/appointments/list/messaging_screen/messaging_screen.dart';
import 'package:doctorq/screens/appointments/list/video_call_screen/video_call_screen.dart';
import 'package:doctorq/screens/appointments/list/voice_call_ringing_screen/voice_call_ringing_screen.dart';
import 'package:doctorq/screens/appointments/list/voice_call_screen/voice_call_screen.dart';
import 'package:doctorq/screens/audio_resolution.dart';
import 'package:doctorq/screens/chat_resolution.dart';
import 'package:doctorq/screens/online_reception_audio.dart';
import 'package:doctorq/screens/online_reception_chat.dart';
import 'package:doctorq/screens/online_reception_video.dart';
import 'package:doctorq/screens/ser_view.dart';
import 'package:doctorq/screens/video_resolution.dart';
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
  final bool isPast;

  const AppointmentListItem(
      {Key? key, required this.index, required this.item, required this.isPast})
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
              builder: (context) => AppointmentsListVoiceCallScreen(
                    appointment: AppointmentsModel(
                        img: '',
                        id: '',
                        name: 'Запись',
                        contactMethodIcon: '',
                        status: '',
                        time: '13-00'),
                    user: '{"user_id":"1"}',
                  )));
      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: item['appointment_unique_id'],
            room: room_url,
            prefs: prefs,
            callClient: client,
          ),
        ),
      );*/
    } else {
      var prefs = await SharedPreferences.getInstance();
      final client = await CallClient.create();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: item['appointment_unique_id'],
            room: 'https://ser-tele-med.daily.co/test_room',
            prefs: prefs,
            callClient: client,
          ),
        ),
      );
      print("no room");

      //https://ser-tele-med.daily.co/test_room
    }
  }

  void navigateToScreenWithTypes(BuildContext context,bool isPast) async {
    print("Navigating...");
context.setSelectedAppointmentByIndex(index);
print(item['id']);
print(context.selectedAppointment);
    try {
      // Check if item exists
      if (item == null || item["description"] == null) {
        print("Error: item or description is null");
        return;
      }

      String description = item["description"];

      switch (description) {
        case "ContactMethods.message": 
          print("message");
          isPast==false ?
          
          Navigator.push(
             // context, MaterialPageRoute(builder: (context) => ChatScreen()));
             context, MaterialPageRoute(builder: (context) => OnlineReceptionChat()))
      
      :
          Navigator.push(
             // context, MaterialPageRoute(builder: (context) => ChatScreen()));
             context, MaterialPageRoute(builder: (context) => ChatResolution()));
      
      
          break;
        case "ContactMethods.voiceCall":
           isPast==false ?
              Navigator.push(
             // context, MaterialPageRoute(builder: (context) => ChatScreen()));
             context, MaterialPageRoute(builder: (context) => OnlineReceptionAudio()))
            :    Navigator.push(
             // context, MaterialPageRoute(builder: (context) => ChatScreen()));
             context, MaterialPageRoute(builder: (context) => AudioResolution()));
      

          /*
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentsListVoiceCallScreen(
                        appointment: AppointmentsModel(
                            img: '',
                            id: '',
                            name: 'Запись',
                            contactMethodIcon: '',
                            status: '',
                            time: '13-00'),
                        user: '{"user_id":"1"}',
                      )));*/
          break;
        case "ContactMethods.videoCall":
          try {
            var prefs = await SharedPreferences.getInstance();
            final client = await CallClient.create();


                isPast==false ?
      
                   Navigator.push(
             // context, MaterialPageRoute(builder: (context) => ChatScreen()));
             context, MaterialPageRoute(builder: (context) => OnlineReceptionVideo()))
             :
                    Navigator.push(
             // context, MaterialPageRoute(builder: (context) => ChatScreen()));
             context, MaterialPageRoute(builder: (context) => VideoResolution()));
          
             //start video commented
/*
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    print(item['doctor']);
    return InkWell(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          12.00,
        ),
      ),
      onTap: () {
        print("hello");
        ser(context, isPast);
      },
      child: Container(
        // height: getVerticalSize(100),
        //  margin: getMargin(top: 8.0, bottom: 8.0, right: 20, left: 20),

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
                    child: Container(
                      width: getSize(160), // Set fixed width for avatar
                      height: getSize(160), // Set fixed height for avatar
                      child: CircleAvatar(
                        radius: getSize(10), // Use radius instead of minRadius
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                            child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? ColorConstant.darkLine
                                  : ColorConstant.bluegray50,
                              width: getHorizontalSize(1.00),
                            ),
                          ),
                          child: Image.network(
                            item["doctor"]["photo"],
                            fit: BoxFit.contain,
                            width: getSize(160),
                            height: getSize(160),
                          ),
                        )),
                      ),
                    ),
                  ),
               //   Icon(getImagePathByContactMethod(item),
               //       color: ColorConstant.fromHex("81AEEA")),
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
                            item["doctor"]["username"],

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
                        if (item['doctor']['specializations'].isNotEmpty) Text(item['doctor']['specializations'][0]['name']),
                          Text(getContactMethod(item)),
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
                    //      Text(item['date']),
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

  ser(context, isPast) async {
    navigateToScreenWithTypes(context, isPast);
//    navigateToScreen(context);
    return;
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
      if (!isPast) {
        navigateToScreen(context);
      }
    } else {
      print("not okey");
      // Request permissions
    }
  }

  getContactMethod(Map item) {
    if (item["description"] == "ContactMethods.voiceCall") {
      return 'Аудио';
    }
    if (item["description"] == "ContactMethods.videoCall") {
      return 'Видео';
    }
    if (item["description"] == "ContactMethods.message") {
      return 'Текстовый чат';
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
