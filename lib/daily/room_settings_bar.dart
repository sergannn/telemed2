import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/daily/logging.dart';
import 'package:doctorq/daily/room_parameters_bottom_sheet.dart';
import 'package:doctorq/daily/main.dart';
import 'package:doctorq/extensions.dart';
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

  // Методы для определения статуса подключения
  Color _getStatusColor(CallState callState) {
    switch (callState) {
      case CallState.joined:
        return Colors.green;
      case CallState.joining:
        return Colors.orange;
      case CallState.leaving:
        return Colors.red;
      case CallState.left:
        return Colors.grey;
      case CallState.initialized:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(CallState callState) {
    switch (callState) {
      case CallState.joined:
        return 'Подключен';
      case CallState.joining:
        return 'Подключение...';
      case CallState.leaving:
        return 'Отключение...';
      case CallState.left:
        return 'Отключен';
      case CallState.initialized:
        return 'Готов к подключению';
      default:
        return 'Неизвестно';
    }
  }

  Color _getButtonColor(CallState callState) {
    switch (callState) {
      case CallState.joined:
        return Colors.red;
      case CallState.joining:
        return Colors.orange;
      case CallState.leaving:
        return Colors.grey;
      case CallState.left:
        return Colors.green;
      case CallState.initialized:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getLoadingText(CallState callState) {
    switch (callState) {
      case CallState.joining:
        return 'Подключение...';
      case CallState.leaving:
        return 'Отключение...';
      default:
        return 'Загрузка...';
    }
  }

  void _showExpiredRoomDialog(BuildContext context, DateTime expDate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 8),
              Text('Комната истекла'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Основная комната истекла в ${expDate.toString().substring(0, 19)}'),
              const SizedBox(height: 12),
              Text('Вы можете:'),
              const SizedBox(height: 8),
              Text('• Создать новую запись с новой комнатой'),
              const SizedBox(height: 4),
              Text('• Перейти в тестовую комнату для отладки'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToTestRoom();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text('Тестовая комната'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToTestRoom() async {
    try {
      const testRoomUrl = 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81';
      
      // Корректно закрываем текущий CallClient
      try {
        await widget.client.leave();
        await Future.delayed(const Duration(milliseconds: 500)); // Даем время на закрытие
      } catch (e) {
        print('Error leaving current room: $e');
      }
      
      // Создаем новый CallClient для тестовой комнаты
      final newCallClient = await CallClient.create();
      
      // Создаем новый DailyApp с тестовой комнатой
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: testRoomUrl,
            room: testRoomUrl,
            prefs: widget.prefs,
            callClient: newCallClient,
          ),
        ),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Переход в тестовую комнату'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      print('Error navigating to test room: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка перехода в тестовую комнату: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  serJoin(canJoin) async {
    print("=== CONTROLLED JOIN/LEAVE ===");
    print("canJoin: $canJoin");
    print("Room URL: ${widget.room}");
    print("Token: $_token");
    print("Current call state: ${widget.client.callState}");
    print("Room URL valid: ${widget.room.isNotEmpty}");
    print("Room URL starts with https: ${widget.room.startsWith('https://')}");
    
    // Проверяем истечение комнаты перед подключением
    if (canJoin) {
      var appointment = context.selectedAppointment;
      if (appointment != null && appointment['room_data'] != null) {
        try {
          var roomData = jsonDecode(appointment['room_data'].toString());
          if (roomData['config'] != null && roomData['config']['exp'] != null) {
            int expTimestamp = roomData['config']['exp'];
            DateTime expDate = DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);
            DateTime now = DateTime.now();
            
            if (expDate.isBefore(now)) {
              print("Room expired at: ${expDate.toString()}");
              _showExpiredRoomDialog(context, expDate);
              return;
            }
          }
        } catch (e) {
          print('Error checking room expiration: $e');
        }
      }
    }
    
    try {
      // ЯВНЫЙ контроль подключения - только по требованию пользователя
      if (canJoin) {
        print("User requested JOIN - connecting to room");
        print("Attempting to join room: ${widget.room}");
        
        // Проверяем что URL валидный
        if (widget.room.isEmpty || !widget.room.startsWith('https://')) {
          print("ERROR: Invalid room URL");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка: Неверный URL комнаты'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        
        // Камера уже включена для предварительного просмотра
        await widget.client.join(url: Uri.parse(widget.room), token: _token);
        print("Successfully JOINED room");
      } else {
        print("User requested LEAVE - disconnecting from room");
        await widget.client.leave();
        print("Successfully LEFT room");
        
        // Переход к экрану отзыва после выхода
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
          ),
        ));
      }
    } on OperationFailedException catch (error, trace) {
      print("Operation failed: $error");
      print("Error details: $trace");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка подключения: $error'),
          backgroundColor: Colors.red,
        ),
      );
      logger.severe(
          'Failed to ${canJoin ? 'join' : 'leave'} call', error, trace);
    } catch (e) {
      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Неожиданная ошибка: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
    
    // Отладочная информация
    print("RoomSettingsBar build - callState: $callState, canJoin: $canJoin, isLoading: $isLoading");
    print("Room URL: ${widget.room}");
    return GestureDetector(
      onTap: isLoading || widget.room == null
          ? null
          : () {
              print("GestureDetector onTap triggered!");
              print("isLoading: $isLoading, room null: ${widget.room == null}");
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
                  Column(
                    children: [
                      // Индикатор статуса подключения
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(callState),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getStatusText(callState),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Кнопка подключения/отключения
                      TextButton(
                        onPressed: isLoading || widget.room == null
                            ? null
                            : () {
                                print("=== TEXTBUTTON PRESSED ===");
                                print("Button pressed - canJoin: $canJoin, callState: $callState");
                                print("isLoading: $isLoading, room null: ${widget.room == null}");
                                serJoin(canJoin);
                              },
                        style: TextButton.styleFrom(
                          backgroundColor: _getButtonColor(callState),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _getLoadingText(callState),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                canJoin ? 'Подключиться' : 'Выйти',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
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
