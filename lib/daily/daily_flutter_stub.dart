// Заглушка для daily_flutter на веб-платформе
class CallClient {
  static Future<CallClient> create() async {
    return CallClient();
  }
  
  dynamic callState;
  dynamic participants;
  
  void setUsername(String username) {}
  void updateSubscriptionProfiles({required Map forProfiles}) {}
  Future<void> join(String roomUrl) async {}
  Future<void> leave() async {}
}

class CallState {
  static const joined = 'joined';
}

