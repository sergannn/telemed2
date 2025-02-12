import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/daily/logging.dart';
import 'package:doctorq/daily/room_parameters_bottom_sheet.dart';
import 'package:doctorq/models/appointment_model.dart';
import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/appointments/list/messaging_ended_screen/messaging_ended_screen.dart';
import 'package:doctorq/screens/appointments/list/write_review_filled_screen/write_review_filled_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:doctorq/utils/utility.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class OnlineController extends GetxController {
  var cats = [].obs; // Reactive list to store fetched items
  var users = [].obs;
  var status = ''.obs;
  late Timer? _timer;
  //get http => null; // Reactive list to store fetched items
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    print("init contreoler");
    super.onInit();
    //это нужно для проверки, онлайн ли доктор
    // startFetchingData();
  }

  void startFetchingData() {
    print("fetching...");
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkDoctor().then((value) {
        // Update the reactive variables here
        status.value = value;
      }).catchError((error) {
        printLog('Error fetching data: $error');
      });
    });
  }

  Future<String> checkDoctor() async {
    // Simulating fetching data from an API
    var response = await http.get(Uri.parse(
//http://localhost:8000/api/get-value?table_name=online&field_to_get=status&where_condition=5
        //'http://h315225216.nichost.ru/itmo2020/Student/doctor/cats.php'
        'https://fu-laravel.onrender.com/api/get-value?table_name=online&field_to_get=status&where_condition=5'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse["value"]["status"];
    } else {
      printLog('Failed to load items');
      return 'false';
    }
  }
}

class RoomSettingsBar extends StatefulWidget {
  const RoomSettingsBar(
      {super.key,
      required this.client,
      required this.prefs,
      required this.room});

  final CallClient client;
  final SharedPreferences prefs;
  final String room;

  @override
  State<RoomSettingsBar> createState() => _RoomSettingsBarState();
}

class _RoomSettingsBarState extends State<RoomSettingsBar> {
  /*late Uri? _url = (() {
    //final previous = widget.prefs.getString(widget.room);
    /*List('roomUrls')?.firstOrNull;
    if (previous == null || previous.isEmpty) {
      return null;
    }*/
    return Uri.tryParse(previous ?? '');
  })();*/
  String? _token;
  final OnlineController onlineController = Get.put(OnlineController());

  serJoin(canJoin) async {
    print("joining..");
    print(canJoin);
    try {
      //var url = widget.prefs.getString(widget.room);
      await (canJoin
          ? widget.client.join(url: Uri.parse(widget.room), token: _token)
          : //() {
          //  print("hmm");
          widget.client.leave());
      if (!canJoin) {
        AppointmentsModel a = AppointmentsModel(
            img: '',
            name: '',
            id: '',
            contactMethodIcon: '',
            status: '',
            time: '');
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => AppointmentsListWriteReviewFilledScreen(
            contactMethod: ContactMethods.videoCall,
            appointment: a,
            //                                   prefs: prefs,
            //                                   callClient: client,
          ),
        ));
      }
      print("Successfully ${canJoin ? 'joined' : 'left'} room");
      //});

      // });
    } on OperationFailedException catch (error, trace) {
      logger.severe(
          'Failed to ${canJoin ? 'join' : 'leave'} call', error, trace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final url = _url;
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    final callState = CallClientState.callStateOf(context);
    final isLoading =
        callState == CallState.joining || callState == CallState.leaving;
    final canJoin =
        callState == CallState.initialized || callState == CallState.left;
    return GestureDetector(
      onTap: isLoading || widget.room == null
          ? null
          : () {
              serJoin(canJoin);
            },
      /*widget.client.callState != CallState.initialized &&
              widget.client.callState != CallState.left
          ? null
          : () async {
              print("settings tap");
              final previous = widget.prefs.getStringList('roomUrls') ?? [];
              final parameters = await showRoomParametersBottomSheet(
                context,
                previous.map(Uri.tryParse).whereNotNull(),
                _token,
              );
              if (parameters != null) {
                final urlStr = parameters.roomUrl.toString();
                final updatedUrls = [
                  urlStr,
                  ...previous.whereNot((it) => it == urlStr).take(9)
                ];
                unawaited(widget.prefs.setStringList('roomUrls', updatedUrls));
                setState(() {
                  //  _url = parameters.roomUrl;
                  _token = parameters.token;
                });
              }
            },*/
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*   Obx(() => onlineController.status.value == 'online'
                      ? TextButton(
                          onPressed: () {
                            print("pressing");
                            serJoin(canJoin);
                          },
                          child: isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : Text(canJoin ? 'Join' : 'Leave',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                        )
                      : */
                  TextButton(
                    onPressed: isLoading || widget.room == null
                        ? null
                        : () {
                            serJoin(canJoin);
                          },
                    child: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : Center(
                            child: Text(canJoin ? 'Подключиться' : 'Выйти',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                  ),
                  /* Text(
                    widget.room,
                    style: widget.room == null
                        ? theme.textTheme.bodyMedium
                        : theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.hintColor),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),*/
                  if (_token != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Token:',
                            style: bodySmall?.copyWith(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            _token ?? '',
                            style: bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
