import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:doctorq/services/consultation_provider_service.dart';

const _tokenEndpoint = 'https://livevideo.postagents.ru/token';
const _defaultRoom = 'telemed-demo';

class LiveVideoJoinScreen extends StatefulWidget {
  const LiveVideoJoinScreen({
    super.key,
    required this.role,
    this.mode = ConsultationMode.video,
    this.initialRoom,
    this.autoJoin = false,
  });

  final String role;
  final ConsultationMode mode;
  final String? initialRoom;
  final bool autoJoin;

  @override
  State<LiveVideoJoinScreen> createState() => _LiveVideoJoinScreenState();
}

class _LiveVideoJoinScreenState extends State<LiveVideoJoinScreen> {
  late final TextEditingController _roomController;
  bool _joining = false;

  String get _roleTitle => widget.role == 'doctor' ? 'врач' : 'пациент';
  String get _modeTitle {
    switch (widget.mode) {
      case ConsultationMode.audio:
        return 'Аудио';
      case ConsultationMode.chat:
        return 'Текст';
      case ConsultationMode.video:
        return 'Видео';
    }
  }

  @override
  void initState() {
    super.initState();
    _roomController = TextEditingController(text: widget.initialRoom ?? _defaultRoom);
    if (widget.autoJoin) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _join());
    }
  }

  @override
  void dispose() {
    _roomController.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final roomName = _roomController.text.trim().isEmpty ? _defaultRoom : _roomController.text.trim();
    final identity = '${widget.role}-${DateTime.now().millisecondsSinceEpoch}';

    setState(() => _joining = true);
    try {
      await _requestPermissions();
      final joinInfo = await _fetchJoinInfo(
        room: roomName,
        role: widget.role,
        identity: identity,
      );

      final room = Room(
        roomOptions: const RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultCameraCaptureOptions: CameraCaptureOptions(
            params: VideoParametersPresets.h720_169,
          ),
        ),
      );
      final listener = room.createListener();

      await room.connect(joinInfo.url, joinInfo.token);
      final mediaWarning = await _enableLocalMedia(room);

      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => LiveVideoCallScreen(
            room: room,
            listener: listener,
            title: '$_modeTitle: $_roleTitle',
            roomName: roomName,
            mode: widget.mode,
            mediaWarning: mediaWarning,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось подключиться: $error')),
      );
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _requestPermissions() async {
    final permissions = <Permission>[];
    if (widget.mode == ConsultationMode.video) permissions.add(Permission.camera);
    if (widget.mode != ConsultationMode.chat) permissions.add(Permission.microphone);
    if (permissions.isNotEmpty) await permissions.request();
  }

  Future<String?> _enableLocalMedia(Room room) async {
    final warnings = <String>[];

    try {
      await room.localParticipant?.setCameraEnabled(widget.mode == ConsultationMode.video);
    } catch (error) {
      if (widget.mode == ConsultationMode.video) warnings.add('камера недоступна: $error');
    }

    try {
      await room.localParticipant?.setMicrophoneEnabled(widget.mode != ConsultationMode.chat);
    } catch (error) {
      if (widget.mode != ConsultationMode.chat) warnings.add('микрофон недоступен: $error');
    }

    if (warnings.isEmpty) return null;
    return 'Комната подключена, но ${warnings.join('; ')}';
  }

  Future<_JoinInfo> _fetchJoinInfo({
    required String room,
    required String role,
    required String identity,
  }) async {
    final uri = Uri.parse(_tokenEndpoint).replace(
      queryParameters: {
        'room': room,
        'role': role,
        'identity': identity,
      },
    );
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw StateError('token endpoint returned ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return _JoinInfo(
      url: data['url'] as String,
      token: data['token'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$_modeTitle консультация')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_modeIcon(widget.mode), size: 72, color: const Color(0xff1e88e5)),
                  const SizedBox(height: 24),
                  Text(
                    'Войти как $_roleTitle',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Для теста врач и пациент должны указать одну комнату.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: _roomController,
                    decoration: const InputDecoration(
                      labelText: 'Комната',
                      prefixIcon: Icon(Icons.meeting_room_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _joining ? null : _join,
                    icon: const Icon(Icons.login_rounded),
                    label: Text('Войти в ${_modeTitle.toLowerCase()} сеанс'),
                  ),
                  if (_joining) ...[
                    const SizedBox(height: 24),
                    const Center(child: CircularProgressIndicator()),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData _modeIcon(ConsultationMode mode) {
  switch (mode) {
    case ConsultationMode.audio:
      return Icons.headset_mic_rounded;
    case ConsultationMode.chat:
      return Icons.chat_bubble_rounded;
    case ConsultationMode.video:
      return Icons.video_call_rounded;
  }
}

class LiveVideoCallScreen extends StatefulWidget {
  const LiveVideoCallScreen({
    super.key,
    required this.room,
    required this.listener,
    required this.title,
    required this.roomName,
    required this.mode,
    this.mediaWarning,
  });

  final Room room;
  final EventsListener<RoomEvent> listener;
  final String title;
  final String roomName;
  final ConsultationMode mode;
  final String? mediaWarning;

  @override
  State<LiveVideoCallScreen> createState() => _LiveVideoCallScreenState();
}

class _LiveVideoCallScreenState extends State<LiveVideoCallScreen> {
  final _messageController = TextEditingController();
  final _messages = <_LiveChatMessage>[];
  EventsListener<RoomEvent> get _listener => widget.listener;

  @override
  void initState() {
    super.initState();
    widget.room.addListener(_refresh);
    _listener
      ..on<ParticipantEvent>((_) => _refresh())
      ..on<DataReceivedEvent>((event) {
        if (event.topic != 'telemed-chat') return;
        final text = utf8.decode(event.data, allowMalformed: true);
        setState(() {
          _messages.add(_LiveChatMessage(
            author: event.participant?.identity ?? 'Собеседник',
            text: text,
            mine: false,
          ));
        });
      })
      ..on<RoomDisconnectedEvent>((_) {
        if (mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
  }

  @override
  void dispose() {
    widget.room.removeListener(_refresh);
    unawaited(_disposeRoom());
    super.dispose();
  }

  Future<void> _disposeRoom() async {
    await widget.room.disconnect();
    await _listener.dispose();
    await widget.room.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();
    setState(() {
      _messages.add(_LiveChatMessage(
        author: widget.room.localParticipant?.identity ?? 'Я',
        text: text,
        mine: true,
      ));
    });
    await widget.room.localParticipant?.publishData(
      utf8.encode(text),
      reliable: true,
      topic: 'telemed-chat',
    );
  }

  Future<void> _leave() async {
    await widget.room.disconnect();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final participants = [
      widget.room.localParticipant,
      ...widget.room.remoteParticipants.values,
    ].whereType<Participant>().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} · ${widget.roomName}'),
        actions: [
          IconButton(
            tooltip: 'Выйти',
            onPressed: _leave,
            icon: const Icon(Icons.call_end_rounded),
          ),
        ],
      ),
      body: participants.isEmpty
          ? const Center(child: Text('Подключаемся...'))
          : Column(
              children: [
                if (widget.mediaWarning != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: MaterialBanner(
                      content: Text(widget.mediaWarning!),
                      leading: const Icon(Icons.info_outline_rounded),
                      actions: const [SizedBox.shrink()],
                    ),
                  ),
                if (widget.mode != ConsultationMode.chat)
                  Expanded(
                    flex: widget.mode == ConsultationMode.video ? 3 : 1,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 520,
                        childAspectRatio: 16 / 10,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: participants.length,
                      itemBuilder: (context, index) {
                        return _ParticipantTile(participant: participants[index]);
                      },
                    ),
                  ),
                Expanded(
                  flex: widget.mode == ConsultationMode.chat ? 1 : 2,
                  child: _LiveChatPanel(
                    messages: _messages,
                    controller: _messageController,
                    onSend: _sendMessage,
                  ),
                ),
              ],
            ),
    );
  }
}

class _LiveChatPanel extends StatelessWidget {
  const _LiveChatPanel({
    required this.messages,
    required this.controller,
    required this.onSend,
  });

  final List<_LiveChatMessage> messages;
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        Expanded(
          child: messages.isEmpty
              ? const Center(child: Text('Сообщений пока нет'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Align(
                      alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: message.mine ? const Color(0xff1e88e5) : const Color(0xffedf2f7),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(color: message.mine ? Colors.white : Colors.black87),
                        ),
                      ),
                    );
                  },
                ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Сообщение',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => onSend(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: onSend,
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LiveChatMessage {
  const _LiveChatMessage({
    required this.author,
    required this.text,
    required this.mine,
  });

  final String author;
  final String text;
  final bool mine;
}

class _ParticipantTile extends StatelessWidget {
  const _ParticipantTile({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    final videoTrack = _videoTrackFor(participant);
    final label = participant.name.isNotEmpty ? participant.name : participant.identity;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xff101b2d)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (videoTrack == null)
              const Center(
                child: Icon(Icons.videocam_off_rounded, size: 64, color: Colors.white38),
              )
            else
              VideoTrackRenderer(videoTrack, renderMode: VideoRenderMode.auto),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VideoTrack? _videoTrackFor(Participant participant) {
    final publications = participant.videoTrackPublications;
    for (final publication in publications) {
      final track = publication.track;
      if (track is VideoTrack && !publication.muted) {
        return track;
      }
    }
    return null;
  }
}

class _JoinInfo {
  const _JoinInfo({
    required this.url,
    required this.token,
  });

  final String url;
  final String token;
}
