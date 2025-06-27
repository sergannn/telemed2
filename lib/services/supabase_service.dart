import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:doctorq/models/appointment_model.dart';

class SupabaseService {
  static final SupabaseClient _client = SupabaseClient(
    'https://larkszrokdqopoxwjdhx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxhcmtzenJva2Rxb3BveHdqZGh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3MTA4NzgsImV4cCI6MjA2NjI4Njg3OH0.bBZTOlyisPWXY-5CvL4IHASgybeDY5TjeP5A8OEaBZQ',
  );

  static SupabaseClient get client => _client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://larkszrokdqopoxwjdhx.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxhcmtzenJva2Rxb3BveHdqZGh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA3MTA4NzgsImV4cCI6MjA2NjI4Njg3OH0.bBZTOlyisPWXY-5CvL4IHASgybeDY5TjeP5A8OEaBZQ',
    );
  }

  static Future<Map<String, dynamic>?> sendMessage({
    required int fromUserId,
    required int toUserId,
    required String text,
    required int appointmentId,
  }) async {
    try {
      final response = await _client.from('text_messages').insert({
        'from': fromUserId,
        'to': toUserId,
        'text': text,
        'appointment_id': appointmentId,
      }).select().single();

      return response;
    } catch (e) {
      print('Error sending message: $e');
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getMessages({
    required int appointmentId,
  }) async {
    try {
      final response = await _client
          .from('text_messages')
          .select()
          .eq('appointment_id', appointmentId)
          .order('created_at', ascending: true);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
}
