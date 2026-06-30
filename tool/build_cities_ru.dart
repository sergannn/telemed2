import 'dart:convert';
import 'dart:io';

const _townsCsvUrl =
    'https://raw.githubusercontent.com/epogrebnyak/ru-cities/main/assets/towns.csv';
const _altNamesUrl =
    'https://raw.githubusercontent.com/epogrebnyak/ru-cities/main/assets/alt_city_names.json';

const _regionTimeZones = <String, String>{
  'Калининградская область': 'Europe/Kaliningrad',
  'Астраханская область': 'Europe/Astrakhan',
  'Волгоградская область': 'Europe/Volgograd',
  'Кировская область': 'Europe/Kirov',
  'Самарская область': 'Europe/Samara',
  'Удмуртская Республика': 'Europe/Samara',
  'Саратовская область': 'Europe/Saratov',
  'Ульяновская область': 'Europe/Ulyanovsk',
  'Республика Башкортостан': 'Asia/Yekaterinburg',
  'Курганская область': 'Asia/Yekaterinburg',
  'Оренбургская область': 'Asia/Yekaterinburg',
  'Пермский край': 'Asia/Yekaterinburg',
  'Свердловская область': 'Asia/Yekaterinburg',
  'Тюменская область': 'Asia/Yekaterinburg',
  'Челябинская область': 'Asia/Yekaterinburg',
  'Омская область': 'Asia/Omsk',
  'Алтайский край': 'Asia/Barnaul',
  'Республика Алтай': 'Asia/Barnaul',
  'Кемеровская область - Кузбасс': 'Asia/Novokuznetsk',
  'Новосибирская область': 'Asia/Novosibirsk',
  'Томская область': 'Asia/Tomsk',
  'Красноярский край': 'Asia/Krasnoyarsk',
  'Республика Тыва': 'Asia/Krasnoyarsk',
  'Республика Хакасия': 'Asia/Krasnoyarsk',
  'Иркутская область': 'Asia/Irkutsk',
  'Республика Бурятия': 'Asia/Irkutsk',
  'Забайкальский край': 'Asia/Chita',
  'Амурская область': 'Asia/Yakutsk',
  'Еврейская автономная область': 'Asia/Vladivostok',
  'Приморский край': 'Asia/Vladivostok',
  'Хабаровский край': 'Asia/Vladivostok',
  'Сахалинская область': 'Asia/Sakhalin',
  'Магаданская область': 'Asia/Magadan',
  'Камчатский край': 'Asia/Kamchatka',
  'Чукотский автономный округ': 'Asia/Anadyr',
};

const _aoTimeZones = <String, String>{
  'Ненецкий автономный округ': 'Europe/Moscow',
  'Ханты-Мансийский автономный округ - Югра': 'Asia/Yekaterinburg',
  'Ямало-Ненецкий автономный округ': 'Asia/Yekaterinburg',
};

const _districtDefaults = <String, String>{
  'Центральный': 'Europe/Moscow',
  'Северо-Западный': 'Europe/Moscow',
  'Южный': 'Europe/Moscow',
  'Северо-Кавказский': 'Europe/Moscow',
  'Приволжский': 'Europe/Moscow',
  'Уральский': 'Asia/Yekaterinburg',
  'Сибирский': 'Asia/Novosibirsk',
  'Дальневосточный': 'Asia/Vladivostok',
};

Future<void> main() async {
  final outputFile = File('assets/data/cities_ru.json');

  stdout.writeln('Downloading towns.csv...');
  final townsCsv = await _fetchText(_townsCsvUrl);
  stdout.writeln('Downloading alt_city_names.json...');
  final altNamesJson = await _fetchText(_altNamesUrl);

  final altNames = (jsonDecode(altNamesJson) as Map<String, dynamic>).map(
    (key, value) => MapEntry(key.trim(), value.toString().trim()),
  );
  final rows = _parseCsv(townsCsv);
  if (rows.isEmpty) {
    throw StateError('towns.csv is empty');
  }

  final header = rows.first;
  final cities = <Map<String, dynamic>>[];

  for (final row in rows.skip(1)) {
    if (row.length != header.length) {
      continue;
    }

    final data = <String, String>{};
    for (var i = 0; i < header.length; i++) {
      data[header[i]] = row[i];
    }

    final name = data['city']?.trim() ?? '';
    if (name.isEmpty) continue;

    final regionName = data['region_name']?.trim() ?? '';
    final regionAo = data['region_name_ao']?.trim() ?? '';
    final federalDistrict = data['federal_district']?.trim() ?? '';
    final lat = double.tryParse(data['lat'] ?? '');
    final lng = double.tryParse(data['lon'] ?? '');
    if (lat == null || lng == null) continue;

    final aliases = _collectAliases(name, altNames);
    final timeZone =
        _resolveTimeZone(regionName, regionAo, federalDistrict, lng);

    cities.add({
      'name': name,
      'region': regionName,
      'regionAo': regionAo.isEmpty ? null : regionAo,
      'regionIsoCode': data['region_iso_code'],
      'federalDistrict': federalDistrict,
      'population': double.tryParse(data['population'] ?? '') ?? 0,
      'lat': lat,
      'lng': lng,
      'timeZone': timeZone,
      'aliases': aliases,
      'searchTokens': _buildSearchTokens(name, aliases),
    });
  }

  cities.sort((a, b) {
    final populationCompare =
        (b['population'] as num).compareTo(a['population'] as num);
    if (populationCompare != 0) return populationCompare;
    return (a['name'] as String).compareTo(b['name'] as String);
  });

  await outputFile.parent.create(recursive: true);
  await outputFile.writeAsString(
    const JsonEncoder.withIndent('  ').convert(cities),
    encoding: utf8,
  );

  stdout.writeln('Generated ${cities.length} cities -> ${outputFile.path}');
}

Future<String> _fetchText(String url) async {
  Object? lastError;

  for (var attempt = 1; attempt <= 3; attempt++) {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode != 200) {
        throw HttpException(
          'Failed to fetch $url: HTTP ${response.statusCode}',
          uri: Uri.parse(url),
        );
      }
      return await response.transform(utf8.decoder).join();
    } catch (error) {
      lastError = error;
    } finally {
      client.close(force: true);
    }
  }

  final curlResult = await Process.run('curl', [
    '-L',
    '--fail',
    '--silent',
    '--show-error',
    url,
  ]);
  if (curlResult.exitCode == 0) {
    return curlResult.stdout.toString();
  }

  throw StateError(
    'Failed to fetch $url. Last HTTP error: $lastError. '
    'curl stderr: ${curlResult.stderr}',
  );
}

List<List<String>> _parseCsv(String source) {
  final rows = <List<String>>[];
  final currentRow = <String>[];
  final currentField = StringBuffer();
  var inQuotes = false;

  for (var i = 0; i < source.length; i++) {
    final char = source[i];

    if (char == '"') {
      if (inQuotes && i + 1 < source.length && source[i + 1] == '"') {
        currentField.write('"');
        i++;
      } else {
        inQuotes = !inQuotes;
      }
      continue;
    }

    if (!inQuotes && char == ',') {
      currentRow.add(currentField.toString());
      currentField.clear();
      continue;
    }

    if (!inQuotes && (char == '\n' || char == '\r')) {
      if (char == '\r' && i + 1 < source.length && source[i + 1] == '\n') {
        i++;
      }
      currentRow.add(currentField.toString());
      currentField.clear();
      if (currentRow.any((cell) => cell.isNotEmpty)) {
        rows.add(List<String>.from(currentRow));
      }
      currentRow.clear();
      continue;
    }

    currentField.write(char);
  }

  if (currentField.isNotEmpty || currentRow.isNotEmpty) {
    currentRow.add(currentField.toString());
    rows.add(List<String>.from(currentRow));
  }

  return rows;
}

List<String> _collectAliases(
  String city,
  Map<String, String> altNames,
) {
  final aliases = <String>{city};
  for (final entry in altNames.entries) {
    if (entry.key == city) {
      aliases.add(entry.value);
    }
    if (entry.value == city) {
      aliases.add(entry.key);
    }
  }
  return aliases.toList()..sort();
}

List<String> _buildSearchTokens(String city, List<String> aliases) {
  final tokens = <String>{};
  for (final value in [city, ...aliases]) {
    final normalized = _normalize(value);
    if (normalized.isNotEmpty) {
      tokens.add(normalized);
    }
  }
  return tokens.toList()..sort();
}

String _resolveTimeZone(
  String regionName,
  String regionAo,
  String federalDistrict,
  double lon,
) {
  if (_regionTimeZones.containsKey(regionName)) {
    return _regionTimeZones[regionName]!;
  }
  if (_aoTimeZones.containsKey(regionAo)) {
    return _aoTimeZones[regionAo]!;
  }

  if (regionName == 'Республика Саха (Якутия)') {
    if (lon < 132) return 'Asia/Yakutsk';
    if (lon < 143) return 'Asia/Khandyga';
    return 'Asia/Ust-Nera';
  }

  return _districtDefaults[federalDistrict] ?? 'Europe/Moscow';
}

String _normalize(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll('ё', 'е')
      .replaceAll(RegExp(r'\s+'), ' ');
}
