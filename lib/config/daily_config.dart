class DailyConfig {
  // API ключ Daily.co (от аккаунта telemed2.daily.co)
  static const String apiKey = 'f1486d50b624ea73ec60b53c1f802899565f394d24705359d0fd70521a062b20';
  
  // Базовый URL для Daily.co API
  static const String baseUrl = 'https://api.daily.co/v1';
  
  // Домен для комнат (API ключ от этого аккаунта)
  static const String domain = 'telemed2.daily.co';
  
  // Альтернативный домен (используется бэкендом - ДРУГОЙ аккаунт!)
  static const String domainBackend = 'ser-tele-med.daily.co';
  
  // Тестовая комната (проверена, работает, истекает 2026)
  // Room ID: 9ae35a95-7b74-4933-b25f-da42f3f4dc9e
  // EXP: 1784200260 (далеко в будущем)
  static const String testRoomUrl = 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81';
}