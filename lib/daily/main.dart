// © 2022 Daily, Co. All Rights Reserved

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/daily/app_message.dart';
import 'package:doctorq/daily/chat_button.dart';
import 'package:doctorq/daily/chat_message.dart';
import 'package:doctorq/daily/device_settings_bar.dart';
import 'package:doctorq/daily/local_participant_view.dart';
import 'package:doctorq/daily/logging.dart';
import 'package:doctorq/daily/participant_list_bottom_sheet.dart';
import 'package:doctorq/daily/recording_button.dart';
import 'package:doctorq/daily/remote_participant_view.dart';
import 'package:doctorq/daily/room_settings_bar.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/online_reception_chat.dart';
import 'package:doctorq/screens/online_reception_video.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wakelock/wakelock.dart';

import 'package:doctorq/screens/main_screen.dart';
/*Future<void> main() async {
  print("main");
  WidgetsFlutterBinding.ensureInitialized();
  initLogging();
  final client = await CallClient.create();
  print("waiting shared");
  var pr = await SharedPreferences.getInstance();
  print("ok");
  runApp(DailyApp(prefs: pr, callClient: client));
}*/

class DailyApp extends StatefulWidget {
  const DailyApp(
      {super.key,
      required this.prefs,
      required this.callClient,
      required this.room,
      required this.appointment_unique_id});

  final SharedPreferences prefs;
  final CallClient callClient;
  final String room;
  final String appointment_unique_id;
  @override
  State<DailyApp> createState() => _MyAppState();
}

class _MyAppState extends State<DailyApp> {
  bool _hasActiveCall = false;
  bool _wasCameraEnabled = false;
  bool _wasMicrophoneEnabled = false;
  StreamSubscription? _eventSubscription;
  final _participantFocusPriority = <ParticipantId>[];
  ParticipantId? _activeSpeakerToSet;
  Timer? _setActiveSpeakerTimer;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();
  final ValueNotifier<List<ChatMessage>> _messageNotifier = ValueNotifier([]);
  final ValueNotifier<List<ParticipantId>> _participantListUpdatedNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    print("main state inited");
    print("its a room data:");
//    widget.room = "a";
    print(widget.room);
    //widget.pre

    // main();
    // WidgetsFlutterBinding.ensureInitialized();
    // initLogging();
    widget.callClient
      ..setUsername("guest")
      //..setUsername(widget.prefs.getString('username') ?? 'Guest')
      ..updateSubscriptionProfiles(
        forProfiles: {
          SubscriptionProfile.base: const MediaSubscriptionSettingsUpdate.set(
            camera: VideoSubscriptionSettingsUpdate.set(
              subscriptionState: SubscriptionStateUpdate.unsubscribed,
            ),
          ),
          SubscriptionProfile.activeRemote:
              const MediaSubscriptionSettingsUpdate.set(
            camera: VideoSubscriptionSettingsUpdate.set(
              subscriptionState: SubscriptionStateUpdate.subscribed,
            ),
          ),
        },
      )
      ..setInputsEnabled(camera: true, microphone: true);
    _eventSubscription = widget.callClient.events.listen(_handleEvent);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    final participantIds = widget.callClient.participants.remote.keys
        .whereNot(_participantFocusPriority.contains);
    if (!const IterableEquality()
        .equals(participantIds, _participantListUpdatedNotifier.value)) {
      _participantListUpdatedNotifier.value = [...participantIds];
    }
  }

  void _handleEvent(Event event) {
    if (!mounted) return;
    event.whenOrNull<void>(
      callStateUpdated: (callStateData) {
        setState(() {
          final callState = callStateData.state;
          callStateData.whenOrNull(
            joining: () => {}, //unawaited(Wakelock.toggle(enable: true)),
            joined: (config) {
              final initialUsername = config.initialUserName;
              if (initialUsername != null && initialUsername.isNotEmpty) {
                widget.callClient.setUsername(initialUsername);
              }
              if (!config.initialCameraEnabled ||
                  !config.initialMicrophoneEnabled) {
                widget.callClient.updateInputs(
                  inputs: InputSettingsUpdate.set(
                    camera: config.initialCameraEnabled
                        ? null
                        : const CameraInputSettingsUpdate.set(
                            isEnabled: BoolUpdate.set(false)),
                    microphone: config.initialMicrophoneEnabled
                        ? null
                        : const MicrophoneInputSettingsUpdate.set(
                            isEnabled: BoolUpdate.set(false)),
                  ),
                );
              }
            },
            left: () {
              _participantFocusPriority.clear();
              _messageNotifier.value = [];
              // The camera and mic are automatically disabled after a call, set them back to what they were.
              widget.callClient.setInputsEnabled(
                  camera: _wasCameraEnabled, microphone: _wasMicrophoneEnabled);
              //unawaited(Wakelock.toggle(enable: false));
            },
          );
          _hasActiveCall =
              callState == CallState.joining || callState == CallState.joined;
        });
      },
      inputsUpdated: (inputs) => setState(() {
        _wasCameraEnabled = inputs.camera.isEnabled;
        _wasMicrophoneEnabled = inputs.microphone.isEnabled;
      }),
      activeSpeakerChanged: (participant) {
        if (!_hasActiveCall ||
            participant == null ||
            participant.info.isLocal ||
            participant.id == _participantFocusPriority.firstOrNull) return;
        _activeSpeakerToSet = participant.id;
        if (_participantFocusPriority.length < 2) {
          _updateActiveSpeaker();
        } else {
          _setActiveSpeakerTimer ??=
              Timer(const Duration(seconds: 2), _updateActiveSpeaker);
        }
      },
      participantJoined: (participant) {
        if (!_hasActiveCall ||
            participant.info.isLocal ||
            _participantFocusPriority.length >= 3) {
          return;
        }
        setState(() => _participantFocusPriority.add(participant.id));
        _updateSubscriptions();
      },
      participantLeft: (participant) => setState(() {
        _participantFocusPriority.remove(participant.id);
        final participants = widget.callClient.participants;
        if (_participantFocusPriority.length >=
            min(3, participants.remote.length)) return;
        for (final participantId in participants.remote.keys) {
          if (!_participantFocusPriority.contains(participantId)) {
            _participantFocusPriority.add(participantId);
          }
          if (_participantFocusPriority.length >= 3) break;
        }
        _updateSubscriptions();
      }),
      appMessageReceived: _handleAppMessage,
      error: (error) => _scaffoldMessengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text(error))),
    );
  }

  void _updateActiveSpeaker() {
    final activeSpeakerToSet = _activeSpeakerToSet;
    if (mounted && _hasActiveCall && activeSpeakerToSet != null) {
      setState(() {
        _participantFocusPriority
          ..remove(activeSpeakerToSet)
          ..insert(0, activeSpeakerToSet);
        if (_participantFocusPriority.length > 3) {
          _participantFocusPriority.removeRange(
              3, _participantFocusPriority.length);
        }
      });
    }
    _activeSpeakerToSet = null;
    _setActiveSpeakerTimer = null;
    _updateSubscriptions();
  }

  void _updateSubscriptions() {
    widget.callClient.updateSubscriptions(
      // Profile-wide settings updates are applied before changes to individual participant subscriptions.
      forParticipantsWithProfiles: {
        SubscriptionProfile.activeRemote: const SubscriptionSettingsUpdate.set(
          profile:
              SubscriptionProfileUpdate.set(profile: SubscriptionProfile.base),
        ),
      },
      forParticipants: {
        for (final id in _participantFocusPriority)
          id: const SubscriptionSettingsUpdate.set(
            profile: SubscriptionProfileUpdate.set(
              profile: SubscriptionProfile.activeRemote,
            ),
          ),
      },
    );
  }

  void _handleAppMessage(final String data, final ParticipantId from) {
    _handleParsedAppMessage(AppMessage.fromJson(jsonDecode(data)), from);
  }

  void _handleParsedAppMessage(
      final AppMessage data, final ParticipantId from) {
    if (!_hasActiveCall) return;
    data.whenOrNull<void>(
      chatMessage: (message) {
        // Set the participant ID to "from"
        final msg = ChatMessage(
          fromParticipantId: from,
          fromParticipantName: message.fromParticipantName,
          date: message.date,
          received: message.received,
          message: message.message,
          room: message.room,
          local: message.local,
          reactions: message.reactions,
        );
        _messageNotifier.value = [..._messageNotifier.value..add(msg)];
      },
      chatMessageReaction: (reaction) {
        final index =
            _messageNotifier.value.indexWhere(reaction.message.isSameAs);
        if (index < 0) return;
        final message = _messageNotifier.value.elementAt(index);
        final reactionParticipants = {
          ...message.reactions[reaction.reaction]?.toSet() ?? {}
        };
        _messageNotifier.value[index] = message.copyWith(
          reactions: {
            ...message.reactions,
            reaction.reaction: reactionParticipants.contains(from)
                ? (reactionParticipants..remove(from))
                : (reactionParticipants..add(from)),
          },
        );
        _messageNotifier.value = [..._messageNotifier.value];
      },
    );
  }

  Widget _buildRoomInfoPanel() {
    // Проверяем, является ли это тестовой комнатой
    bool isTestRoom = widget.room.contains('lFxg9A2Hi3PLrMdYKF81');
    
    // Получаем room_data из контекста для отображения времени истечения
    var appointment = context.selectedAppointment;
    String expirationInfo = '';
    bool isExpired = false;
    
    if (appointment != null && appointment['room_data'] != null) {
      try {
        var roomData = jsonDecode(appointment['room_data'].toString());
        if (roomData['config'] != null && roomData['config']['exp'] != null) {
          int expTimestamp = roomData['config']['exp'];
          DateTime expDate = DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);
          DateTime now = DateTime.now();
          
          if (expDate.isBefore(now)) {
            isExpired = true;
            expirationInfo = 'Комната истекла: ${expDate.toString().substring(0, 19)}';
          } else {
            Duration remaining = expDate.difference(now);
            int hours = remaining.inHours;
            int minutes = remaining.inMinutes % 60;
            expirationInfo = 'Истекает через: ${hours}ч ${minutes}м (${expDate.toString().substring(0, 19)})';
          }
        }
      } catch (e) {
        print('Error parsing room_data for expiration: $e');
      }
    }
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isTestRoom ? Colors.orange.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isTestRoom ? Colors.orange : Colors.blue, 
          width: 1
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isTestRoom ? Icons.warning : Icons.info_outline, 
                color: isTestRoom ? Colors.orange : Colors.blue, 
                size: 16
              ),
              const SizedBox(width: 8),
              Text(
                isTestRoom ? 'Тестовая комната' : 'Информация о подключении',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isTestRoom ? Colors.orange : Colors.blue,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ID записи: ${widget.appointment_unique_id}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            'URL комнаты:',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              widget.room,
              style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          if (!isTestRoom) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isExpired ? Colors.red.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isExpired ? Colors.red.withOpacity(0.3) : Colors.blue.withOpacity(0.3)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isExpired ? Icons.error : Icons.schedule, 
                        color: isExpired ? Colors.red : Colors.blue, 
                        size: 14
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isExpired ? 'Комната истекла' : 'Время жизни комнаты',
                        style: TextStyle(
                          fontSize: 11,
                          color: isExpired ? Colors.red : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (expirationInfo.isNotEmpty) ...[
                    Text(
                      expirationInfo,
                      style: TextStyle(
                        fontSize: 10, 
                        color: isExpired ? Colors.red : Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    isExpired 
                      ? '⚠️ Комната недоступна. Создайте новую запись'
                      : 'ℹ️ Комната действительна в течение 1 часа',
                    style: TextStyle(
                      fontSize: 10, 
                      color: isExpired ? Colors.red : Colors.blue, 
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  if (isExpired) ...[
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _navigateToTestRoom(),
                      icon: Icon(Icons.science, size: 16),
                      label: Text('Тестовая комната'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Text(
                'ℹ️ Тестовая комната для отладки',
                style: const TextStyle(
                  fontSize: 10, 
                  color: Colors.orange, 
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _navigateToTestRoom() async {
    try {
      const testRoomUrl = 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81';
      
      // Корректно закрываем текущий CallClient
      try {
        await widget.callClient.leave();
        await Future.delayed(const Duration(milliseconds: 500)); // Даем время на закрытие
      } catch (e) {
        print('Error leaving current room: $e');
      }
      
      // Создаем новый CallClient для тестовой комнаты
      final newCallClient = await CallClient.create();
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DailyApp(
            appointment_unique_id: 'TEST_ROOM_${widget.appointment_unique_id}',
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

  bottomDailyNavBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text("a"),
                  DeviceSettingsBar(client: widget.callClient),
                ],
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsetsDirectional.only(end: 20),
                child: AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: widget.callClient.callState != CallState.joined
                      ? const SizedBox()
                      : ChatButton(
                          client: widget.callClient,
                          messageNotifier: _messageNotifier,
                          onChatMessageSent: (chatMessage) =>
                              _handleParsedAppMessage(
                            AppMessage.chatMessage(message: chatMessage),
                            widget.callClient.participants.local.id,
                          ),
                          onChatMessageReactionSent: (chatMessageReaction) =>
                              _handleParsedAppMessage(
                            AppMessage.chatMessageReaction(
                                reaction: chatMessageReaction),
                            widget.callClient.participants.local.id,
                          ),
                        ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("sfdslkfjdslkfjslkja"),
              // RecordingButton(client: widget.callClient, prefs: widget.prefs),
              Expanded(
                  child: RoomSettingsBar(
                      room: widget.room,
                      client: widget.callClient,
                      prefs: widget.prefs)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    widget.callClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('building');
    //print(widget.callClient.callState);
    final focusedParticipantId = _participantFocusPriority.firstOrNull;
    final nextParticipant1 = _participantFocusPriority.length > 1
        ? _participantFocusPriority.elementAt(1)
        : null;
    final nextParticipant2 = _participantFocusPriority.length > 2
        ? _participantFocusPriority.elementAt(2)
        : null;
    return Scaffold(
        //scaffoldMessengerKey: _scaffoldMessengerKey,
        body: CallClientStateProvider(
      callClient: widget.callClient,
      child: Scaffold(
          appBar: AppBar(title: const Text('Подготовка к звонку')),
          bottomNavigationBar: 1 == 1 ? bottomDailyNavBar() : null,
          body: 1 == 2
              ? Text("a")
              : SingleChildScrollView(
                  // height: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Информация о комнате
                      _buildRoomInfoPanel(),
                      bottomDailyNavBar(),
                      // Text('aaaa'),
                      Row(children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: LocalParticipantView(
                                client: widget.callClient,
                                prefs: widget.prefs)),
                      ]),
                      focusedParticipantId != null
                          ? RemoteParticipantView(
                              client: widget.callClient,
                              participantId: focusedParticipantId,
                              size: const Size.fromHeight(256),
                            )
                          : Text("waiting"),
                      if (widget.callClient.callState == CallState.joined &&
                          focusedParticipantId == null) ...[
                        const SizedBox(height: 80),
                        const Center(
                            child: CircularProgressIndicator(strokeWidth: 2)),
                        Text("Ожидаем подключения пользователя...")
                      ],
                      /*   if (focusedParticipantId != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: RemoteParticipantView(
                                client: widget.callClient,
                                participantId: focusedParticipantId,
                                size: const Size.fromHeight(256),
                              ),
                            ),*/
                      if (_participantFocusPriority.length > 1)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /*  if (nextParticipant1 != null)
                                    RemoteParticipantView(
                                      client: widget.callClient,
                                      participantId: nextParticipant1,
                                      size: const Size.square(128),
                                    ),*/
                              /*     if (nextParticipant2 != null)
                                    RemoteParticipantView(
                                      client: widget.callClient,
                                      participantId: nextParticipant2,
                                      size: const Size.square(128),
                                    ),*/
                              if (_participantListUpdatedNotifier
                                  .value.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    return InkWell(
                                      onTap: () {
                                        showParticipantListBottomSheet(
                                          context,
                                          widget.callClient,
                                          _participantListUpdatedNotifier,
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.group),
                                          const SizedBox(width: 2),
                                          Text(
                                            '+${_participantListUpdatedNotifier.value.length}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();

  for (var entry in statuses.entries) {
    final permission = entry.key;
    final status = entry.value;

    switch (status) {
      case PermissionStatus.granted:
        print('${permission} granted');
        break;

      case PermissionStatus.permanentlyDenied:
        print('${permission} permanently denied');
        // Optionally, you can open app settings here
        //openAppSettings();
        break;
      default:
        print('${permission} status unknown');
    }
  }
}
