// © 2022 Daily, Co. All Rights Reserved

import 'dart:async';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/daily/user_settings_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalParticipantView extends StatefulWidget {
  const LocalParticipantView(
      {super.key, required this.client, required this.prefs});

  final CallClient client;
  final SharedPreferences prefs;

  @override
  State<LocalParticipantView> createState() => _LocalParticipantViewState();
}

class _LocalParticipantViewState extends State<LocalParticipantView> {
  StreamSubscription? _eventSubscription;
  final _controller = VideoViewController();
  //double? localSize = 1.2;
  double localSize = 0.4; // Default full size
  bool isSmallSize = true;
  @override
  void initState() {
    super.initState();
    _controller.setTrack(widget.client.participants.local.media?.camera.track);
    _eventSubscription = widget.client.events.listen((event) {
      if (!mounted) return;
      event.whenOrNull<void>(
        inputsUpdated: (inputs) {
          _controller.setTrack(inputs.camera.isEnabled
              ? widget.client.participants.local.media?.camera.track
              : null);
        },
        participantUpdated: (participant) {
          if (!participant.info.isLocal) return;
          _controller.setTrack(widget.client.inputs.camera.isEnabled
              ? participant.media?.camera.track
              : null);
        },
      );
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dialogBuilder(BuildContext context, _controller) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
            onTap: () {
              print("a");
              Navigator.of(context).pop();
            },
            child: Stack(children: [
              VideoView(controller: _controller, fit: VideoViewFit.cover)
            ]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(isSmallSize);
    final username = CallClientState.usernameOf(context);
    final mirrorVideoView =
        CallClientState.inputsOf(context).camera.settings.facingMode ==
            MediaTrackFacingMode.user;
    return GestureDetector(
      onTap: () async {
        print("tap local");
        _dialogBuilder(context, _controller);
        /* setState(() {
          isSmallSize = !isSmallSize;
          localSize = isSmallSize ? 0.3 : 0.8;
       
        });*/
        /*     final newUsername =
            await showUserSettingsBottomSheet(context, username);
        if (!mounted || newUsername == null) return;
        await widget.client.setUsername(newUsername);
        await widget.prefs.setString('username', newUsername);*/
      },
      child: Stack(
        children: [
          //    Text("aaaaaa"),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            //clipBehavior: Clip.hardEdge,
            child: CallClientState.inputsOf(context).camera.isEnabled
                // Showing the local user to themselves as if in a mirror is common practice
                ? VideoView(controller: _controller, fit: VideoViewFit.cover)
                : const Center(
                    child: Icon(Icons.videocam_off, color: Colors.white)),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(.6),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    username == null || username.isEmpty ? 'Guest' : username,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
