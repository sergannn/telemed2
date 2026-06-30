import 'dart:convert';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:doctorq/daily/main.dart';
import 'package:doctorq/extensions.dart';
import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/live_video/live_video_join_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/theme/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

enum ConsultationProvider { yandex, server }

enum ConsultationMode { video, audio, chat }

class ConsultationProviderService {
  static const _storageKey = 'consultation_provider';
  static const _fallbackDailyRoom = 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81';

  static Future<ConsultationProvider> getProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_storageKey);
    return value == ConsultationProvider.server.name
        ? ConsultationProvider.server
        : ConsultationProvider.yandex;
  }

  static Future<void> setProvider(ConsultationProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, provider.name);
  }

  static Future<void> openAppointment(
    BuildContext context, {
    required String role,
    required ConsultationMode mode,
  }) async {
    final provider = await getProvider();
    if (!context.mounted) return;

    if (provider == ConsultationProvider.server) {
      await _openLiveKit(context, role: role, mode: mode);
      return;
    }

    await _openYandexOrDaily(context, mode: mode);
  }

  static Future<void> _openLiveKit(
    BuildContext context, {
    required String role,
    required ConsultationMode mode,
  }) async {
    final appointment = context.selectedAppointment;
    final roomName = _appointmentRoomName(appointment);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LiveVideoJoinScreen(
          role: role,
          mode: mode,
          initialRoom: roomName,
          reviewAppointment: _reviewAppointment(appointment, mode),
          reviewContactMethod: _reviewContactMethod(mode),
          autoJoin: true,
        ),
      ),
    );
  }

  static Future<void> _openYandexOrDaily(
    BuildContext context, {
    required ConsultationMode mode,
  }) async {
    final appointment = context.selectedAppointment;
    final roomUrl = _extractRoomUrl(appointment['room_data']);

    if (roomUrl != null && roomUrl.contains('telemost.yandex.ru')) {
      await launchUrl(Uri.parse(roomUrl), mode: LaunchMode.externalApplication);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final client = await CallClient.create();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DailyApp(
          appointment_unique_id:
              appointment['appointment_unique_id']?.toString() ?? 'unknown',
          room: roomUrl ?? _fallbackDailyRoom,
          prefs: prefs,
          callClient: client,
          mode: _dailyMode(mode),
        ),
      ),
    );
  }

  static DailyCallMode _dailyMode(ConsultationMode mode) {
    switch (mode) {
      case ConsultationMode.audio:
        return DailyCallMode.audio;
      case ConsultationMode.chat:
        return DailyCallMode.chat;
      case ConsultationMode.video:
        return DailyCallMode.video;
    }
  }

  static String _appointmentRoomName(dynamic appointment) {
    final id = appointment?['appointment_unique_id'] ??
        appointment?['id'] ??
        appointment?['uuid'];
    final raw = id?.toString().trim();
    if (raw == null || raw.isEmpty) return 'telemed-demo';
    return 'appointment-$raw'.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '-');
  }

  static AppointmentsModel _reviewAppointment(
    dynamic appointment,
    ConsultationMode mode,
  ) {
    final doctor = appointment?['doctor'];
    final name = doctor?['username'] ??
        doctor?['name'] ??
        doctor?['user']?['name'] ??
        doctor?['user']?['username'] ??
        'врача';
    final from = appointment?['from_time']?.toString() ?? '';
    final to = appointment?['to_time']?.toString() ?? '';
    final date = appointment?['date']?.toString() ?? '';
    final time = [date, [from, to].where((value) => value.isNotEmpty).join(' - ')]
        .where((value) => value.isNotEmpty)
        .join(' · ');

    return AppointmentsModel(
      img: doctor?['photo']?.toString() ?? doctor?['profile_image']?.toString() ?? '',
      name: name.toString(),
      id: appointment?['id']?.toString() ?? appointment?['appointment_unique_id']?.toString() ?? '',
      contactMethodIcon: _reviewIcon(mode),
      status: 'Завершен',
      time: time,
    );
  }

  static String _reviewIcon(ConsultationMode mode) {
    switch (mode) {
      case ConsultationMode.audio:
        return ImageConstant.call;
      case ConsultationMode.chat:
        return ImageConstant.reviews;
      case ConsultationMode.video:
        return ImageConstant.videocam;
    }
  }

  static ContactMethods _reviewContactMethod(ConsultationMode mode) {
    switch (mode) {
      case ConsultationMode.audio:
        return ContactMethods.voiceCall;
      case ConsultationMode.chat:
        return ContactMethods.message;
      case ConsultationMode.video:
        return ContactMethods.videoCall;
    }
  }

  static String? _extractRoomUrl(dynamic roomData) {
    if (roomData == null) return null;
    final raw = roomData.toString();
    if (raw.isEmpty || raw == 'null') return null;
    if (raw.startsWith('https://')) return raw;

    try {
      final decoded = jsonDecode(raw);
      final url = decoded['join_url'] ?? decoded['url'];
      return url?.toString();
    } catch (_) {
      return null;
    }
  }
}
