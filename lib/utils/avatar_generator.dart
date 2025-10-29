import 'dart:math';

class AvatarGenerator {
  static const String _baseUrl = 'https://api.dicebear.com/7.x';
  
  // Стили аватаров для врачей (более профессиональные)
  static const List<String> _doctorStyles = [
    'avataaars',  // Профессиональный стиль
    'personas',   // Реалистичный стиль
    'adventurer', // Дружелюбный стиль
  ];
  
  // Стили аватаров для пациентов (более разнообразные)
  static const List<String> _patientStyles = [
    'avataaars',
    'personas', 
    'adventurer',
    'big-smile',
    'bottts',
    'fun-emoji',
  ];
  
  // Цвета для аватаров
  static const List<String> _colors = [
    '264653', '2a9d8f', 'e9c46a', 'f4a261', 'e76f51',
    '6f42c1', '20c997', 'fd7e14', 'dc3545', '17a2b8',
    '6c757d', '28a745', 'ffc107', '007bff', '6610f2'
  ];
  
  /// Генерирует URL аватара для врача
  static String generateDoctorAvatar({
    String? seed,
    String? gender,
    String? style,
  }) {
    final random = Random();
    final selectedStyle = style ?? _doctorStyles[random.nextInt(_doctorStyles.length)];
    final selectedColor = _colors[random.nextInt(_colors.length)];
    final avatarSeed = seed ?? _generateSeed();
    
    String url = '$_baseUrl/$selectedStyle/svg?seed=$avatarSeed&backgroundColor=$selectedColor';
    
    // Добавляем параметры в зависимости от пола
    if (gender != null) {
      switch (gender.toLowerCase()) {
        case 'male':
        case 'm':
        case 'мужской':
          url += '&hairColor=0e0e0e,2c1b18,724133,a55728,b58143&skinColor=fdbcb4,fd9841';
          break;
        case 'female':
        case 'f':
        case 'женский':
          url += '&hairColor=0e0e0e,2c1b18,724133,a55728,b58143&skinColor=fdbcb4,fd9841';
          break;
      }
    }
    
    return url;
  }
  
  /// Генерирует URL аватара для пациента
  static String generatePatientAvatar({
    String? seed,
    String? gender,
    String? style,
  }) {
    final random = Random();
    final selectedStyle = style ?? _patientStyles[random.nextInt(_patientStyles.length)];
    final selectedColor = _colors[random.nextInt(_colors.length)];
    final avatarSeed = seed ?? _generateSeed();
    
    String url = '$_baseUrl/$selectedStyle/svg?seed=$avatarSeed&backgroundColor=$selectedColor';
    
    // Добавляем параметры в зависимости от пола
    if (gender != null) {
      switch (gender.toLowerCase()) {
        case 'male':
        case 'm':
        case 'мужской':
          url += '&hairColor=0e0e0e,2c1b18,724133,a55728,b58143&skinColor=fdbcb4,fd9841';
          break;
        case 'female':
        case 'f':
        case 'женский':
          url += '&hairColor=0e0e0e,2c1b18,724133,a55728,b58143&skinColor=fdbcb4,fd9841';
          break;
      }
    }
    
    return url;
  }
  
  /// Генерирует случайный seed на основе имени
  static String _generateSeed() {
    final random = Random();
    final adjectives = [
      'happy', 'smart', 'kind', 'brave', 'wise', 'gentle', 'strong', 'calm',
      'bright', 'warm', 'cool', 'fresh', 'bold', 'quiet', 'loud', 'fast'
    ];
    final nouns = [
      'doctor', 'patient', 'person', 'friend', 'helper', 'guide', 'teacher',
      'student', 'worker', 'artist', 'writer', 'reader', 'thinker', 'dreamer'
    ];
    
    return '${adjectives[random.nextInt(adjectives.length)]}-${nouns[random.nextInt(nouns.length)]}-${random.nextInt(999)}';
  }
  
  /// Генерирует seed на основе имени пользователя
  static String generateSeedFromName(String? firstName, String? lastName) {
    if (firstName == null && lastName == null) {
      return _generateSeed();
    }
    
    final name = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    if (name.isEmpty) {
      return _generateSeed();
    }
    
    // Создаем seed на основе имени
    return name.toLowerCase().replaceAll(' ', '-').replaceAll(RegExp(r'[^a-z\-]'), '');
  }
  
  /// Проверяет, является ли URL стандартным аватаром
  static bool isDefaultAvatar(String? url) {
    if (url == null || url.isEmpty) return true;
    
    // Проверяем стандартные пути к аватарам
    return url.contains('male.png') || 
           url.contains('female.png') || 
           url.contains('default') ||
           url.contains('avatar') ||
           url.contains('placeholder');
  }
  
  /// Получает пол из данных пользователя
  static String? getGenderFromUserData(Map<String, dynamic> userData) {
    // Пробуем разные поля для определения пола
    String? gender = userData['gender']?.toString();
    if (gender != null && gender.isNotEmpty) return gender;
    
    gender = userData['sex']?.toString();
    if (gender != null && gender.isNotEmpty) return gender;
    
    // Пытаемся определить по имени (очень приблизительно)
    String? firstName = userData['first_name']?.toString()?.toLowerCase();
    if (firstName != null) {
      if (_isMaleName(firstName)) return 'male';
      if (_isFemaleName(firstName)) return 'female';
    }
    
    return null;
  }
  
  static bool _isMaleName(String name) {
    final maleNames = ['александр', 'алексей', 'андрей', 'антон', 'артем', 'борис', 'вадим', 'валерий', 'василий', 'виктор', 'владимир', 'владислав', 'владислав', 'дмитрий', 'евгений', 'игорь', 'иван', 'кирилл', 'максим', 'михаил', 'николай', 'олег', 'павел', 'петр', 'роман', 'сергей', 'станислав', 'юрий', 'ярослав'];
    return maleNames.contains(name);
  }
  
  static bool _isFemaleName(String name) {
    final femaleNames = ['анна', 'елена', 'ирина', 'мария', 'наталья', 'оксана', 'ольга', 'светлана', 'татьяна', 'юлия', 'александра', 'валентина', 'галина', 'дарья', 'екатерина', 'жанна', 'зоя', 'инна', 'кристина', 'людмила', 'маргарита', 'надежда', 'раиса', 'софья', 'ульяна'];
    return femaleNames.contains(name);
  }
}


