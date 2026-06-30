import 'dart:convert';

import 'package:doctorq/services/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainNotificationsScreen extends StatefulWidget {
  const MainNotificationsScreen({super.key});

  @override
  State<MainNotificationsScreen> createState() =>
      _MainNotificationsScreenState();
}

class _MainNotificationsScreenState extends State<MainNotificationsScreen> {
  late Future<List<DoctorNotificationItem>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _fetchNotifications();
  }

  Future<List<DoctorNotificationItem>> _fetchNotifications() async {
    final currentUser = await Session.getCurrentUser();
    final authToken = currentUser?.authToken;

    if (authToken == null || authToken.isEmpty) {
      throw Exception('Не найден токен авторизации');
    }

    final response = await http.get(
      Uri.parse('https://admin.onlinedoctor.su/api/notifications'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Не удалось загрузить уведомления (${response.statusCode})');
    }

    final body = jsonDecode(response.body);
    final data = body['data'];
    if (data is! List) {
      return [];
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(DoctorNotificationItem.fromJson)
        .toList();
  }

  Future<void> _reload() async {
    setState(() {
      _notificationsFuture = _fetchNotifications();
    });
    await _notificationsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Уведомления',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: _reload,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: FutureBuilder<List<DoctorNotificationItem>>(
                future: _notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return _NotificationsPlaceholder(
                      icon: Icons.error_outline_rounded,
                      title: 'Не удалось загрузить уведомления',
                      subtitle: snapshot.error.toString(),
                    );
                  }

                  final items =
                      snapshot.data ?? const <DoctorNotificationItem>[];
                  if (items.isEmpty) {
                    return const _NotificationsPlaceholder(
                      icon: Icons.notifications_off_outlined,
                      title: 'Уведомлений пока нет',
                      subtitle:
                          'Когда для врача появятся уведомления, они будут показаны здесь.',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _reload,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return NotificationItem(item: items[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item});

  final DoctorNotificationItem item;

  @override
  Widget build(BuildContext context) {
    final createdAt = item.createdAt;
    final timeLabel = createdAt == null
        ? ''
        : DateFormat('dd.MM HH:mm').format(createdAt.toLocal());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 247, 252),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: Icon(
              _iconForType(item.type),
              size: 26,
              color: const Color.fromARGB(255, 142, 191, 231),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title?.trim().isNotEmpty == true
                      ? item.title!
                      : 'Уведомление',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (item.description?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(item.description!),
                ],
                if (item.type?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Text(
                    item.type!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            timeLabel,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  IconData _iconForType(String? type) {
    switch (type) {
      case 'booked':
        return Icons.calendar_today;
      case 'canceled':
        return Icons.event_busy;
      case 'checkout':
        return Icons.check_circle_outline;
      case 'payment_done':
        return Icons.payments_outlined;
      case 'review':
        return Icons.rate_review_outlined;
      case 'live_consultation':
        return Icons.video_call_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }
}

class DoctorNotificationItem {
  const DoctorNotificationItem({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.readAt,
    required this.createdAt,
  });

  final int id;
  final String? title;
  final String? type;
  final String? description;
  final DateTime? readAt;
  final DateTime? createdAt;

  factory DoctorNotificationItem.fromJson(Map<String, dynamic> json) {
    final dataPayload = _extractPayload(json['data']);

    return DoctorNotificationItem(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: json['title']?.toString() ?? dataPayload['title']?.toString(),
      type: json['type']?.toString(),
      description: json['description']?.toString() ??
          dataPayload['description']?.toString() ??
          dataPayload['body']?.toString() ??
          dataPayload['message']?.toString(),
      readAt: DateTime.tryParse(json['read_at']?.toString() ?? ''),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
    );
  }

  static Map<String, dynamic> _extractPayload(dynamic rawData) {
    if (rawData is Map<String, dynamic>) {
      return rawData;
    }

    if (rawData is String && rawData.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(rawData);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
      } catch (_) {
        return {'message': rawData};
      }
    }

    return const {};
  }
}

class _NotificationsPlaceholder extends StatelessWidget {
  const _NotificationsPlaceholder({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 42, color: Colors.black38),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
