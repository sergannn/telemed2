class DailyConfig {
  // API ключ Daily.co (тот же, что используется в Laravel бэкенде)
  static const String apiKey = 'f1486d50b624ea73ec60b53c1f802899565f394d24705359d0fd70521a062b20';
  
  // Базовый URL для Daily.co API
  static const String baseUrl = 'https://api.daily.co/v1';
  
  // Домен для комнат (правильный домен)
  static const String domain = 'telemed2.daily.co';
  
  // Тестовая комната (fallback)
  static const String testRoomUrl = 'https://telemed2.daily.co/lFxg9A2Hi3PLrMdYKF81';
}