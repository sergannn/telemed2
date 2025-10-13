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
    
    // Проверяем, что room_data не null и не пустая строка
    if (roomData != null && roomData.toString().isNotEmpty && roomData.toString() != 'null') {
      // СНАЧАЛА проверяем истечение комнаты
      if (_isRoomExpired(roomData)) {
        print('DEBUG: Room has expired, using test room instead');
        _navigateToTestRoom(context);
        return;
      }
      
      try {
        // Room data exists, proceed with navigation
        var roomUrl = jsonDecode(roomData.toString())['url'];
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
        print("Using real room: $roomUrl");
      } catch (e) {
        print("Error parsing room_data: $e");
        // Fallback to test room if parsing fails
        _navigateToTestRoom(context);
      }
    } else {
      print("No room_data available, using test room");
      _navigateToTestRoom(context);
    }
  }

  void _navigateToTestRoom(BuildContext context) async {
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
    print("Using test room as fallback");
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
          // Переход к экрану с информацией о записи
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineReceptionVideo(),
            ),
          );
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
                            item["patient"]["photo"] ?? 'https://via.placeholder.com/160',
                            fit: BoxFit.contain,
                            width: getSize(160),
                            height: getSize(160),
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: getSize(160),
                                height: getSize(160),
                                color: Colors.grey[300],
                                child: Icon(Icons.person, size: 80, color: Colors.grey[600]),
                              );
                            },
                          ),
                        )),
                      ),
                    ),
                  ),
                  Icon(getImagePathByContactMethod(item),
                      color: ColorConstant.fromHex("81AEEA")),
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
//                            item["doctor"]["username"],

                                item['patient']['username'] ?? "Patient",
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
                       if(item['doctor']['specializations'].isNotEmpty) Text(item['doctor']['specializations'][0]['name']),
                          Row(
                            children: [
                              Text(getContactMethod(item)),
                              SizedBox(width: 8),
                              // Индикация статуса записи и комнаты
                              _buildAppointmentStatusIndicator(item),
                            ],
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
  }

  if (item["description"] == "ContactMethods.voiceCall") {
    return Icons.voice_chat;
  }

  if (item["description"] == "ContactMethods.message") {
    return Icons.message;
  }

  return Icons.calendar_today;
}

  // Метод для создания индикатора статуса записи
  Widget _buildAppointmentStatusIndicator(Map<dynamic, dynamic> item) {
    // Проверяем статус записи
    bool isAppointmentValid = item['status'] != null && item['status'].toString() == '1';
    bool hasRoomData = item['room_data'] != null && item['room_data'].toString().isNotEmpty;
    
    if (isAppointmentValid && hasRoomData) {
      // Запись валидна и комната создана
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green[300]!, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 12, color: Colors.green[700]),
            SizedBox(width: 4),
            Text(
              'Готово',
              style: TextStyle(
                fontSize: 10,
                color: Colors.green[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else if (isAppointmentValid && !hasRoomData) {
      // Запись валидна, но комната не создана
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange[300]!, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, size: 12, color: Colors.orange[700]),
            SizedBox(width: 4),
            Text(
              'Без комнаты',
              style: TextStyle(
                fontSize: 10,
                color: Colors.orange[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      // Запись невалидна
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cancel, size: 12, color: Colors.grey[700]),
            SizedBox(width: 4),
            Text(
              'Неактивна',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
  }
