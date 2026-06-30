import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class CityOption {
  CityOption({
    required this.name,
    required this.region,
    required this.timeZone,
    required this.searchTokens,
  });

  final String name;
  final String region;
  final String timeZone;
  final List<String> searchTokens;

  String get displayLabel {
    if (region.isEmpty || region == name) {
      return name;
    }
    return '$name, $region';
  }

  String? get subtitle {
    if (region.isEmpty || region == name) {
      return null;
    }
    return region;
  }

  factory CityOption.fromJson(Map<String, dynamic> json) {
    final searchTokens = (json['searchTokens'] as List<dynamic>? ?? const [])
        .map((item) => item.toString())
        .toList();

    return CityOption(
      name: json['name']?.toString() ?? '',
      region: json['region']?.toString() ?? '',
      timeZone: json['timeZone']?.toString() ?? 'Europe/Moscow',
      searchTokens: searchTokens,
    );
  }
}

class CityCatalogService {
  static List<CityOption>? _cache;

  static Future<List<CityOption>> loadCities() async {
    if (_cache != null) {
      return _cache!;
    }

    final raw = await rootBundle.loadString('assets/data/cities_ru.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    _cache = decoded
        .map((item) => CityOption.fromJson(item as Map<String, dynamic>))
        .where((city) => city.name.isNotEmpty)
        .toList();
    return _cache!;
  }

  static String normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('ё', 'е')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  static bool matches(CityOption city, String query) {
    final normalizedQuery = normalize(query);
    if (normalizedQuery.isEmpty) {
      return true;
    }

    if (city.searchTokens.any((token) => token.startsWith(normalizedQuery))) {
      return true;
    }

    return city.searchTokens.any((token) => token.contains(normalizedQuery));
  }

  static CityOption? findExactMatch(List<CityOption> cities, String value) {
    final normalized = normalize(value);
    for (final city in cities) {
      if (city.searchTokens.contains(normalized)) {
        return city;
      }
    }
    return null;
  }
}
