import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient supabase = SupabaseClient(
    'https://frvexfoezbscdbcvuxas.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZydmV4Zm9lemJzY2RiY3Z1eGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NDY4ODgsImV4cCI6MjA3NTMyMjg4OH0.XDr9MFxBMX0P42a4MwjstxtZeh_Caqdyrfpfr7d9ec8',
  );
}

Future<List<User?>> getUsers() async {
  try {
    final response = await SupabaseService.supabase
        .from('users_swift')
        .select();
    
    final List<dynamic> data = response;
    final users = data.map((json) => User.fromJson(json)).toList();
    return users;

  } catch (error) {
    print('Error fetching data: $error');
    return [];
  }
}