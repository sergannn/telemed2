import 'dart:convert';
import 'package:http/http.dart' as http;

class HDTSuggestions {
  Future<Map<String, List<Map<String, String>>>> getSuggestions() async {
    final baseUrl = "http://164.90.201.37:8000";
    final url = Uri.parse('$baseUrl/suggestions?time=14:00');

    try {
      final response = await http.get(url, headers: {
        'Accept-Charset': 'utf-8',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        final suggestionsMap = json.decode(responseData['suggestions']);

        return {
          'now': (suggestionsMap['now'] as List)
              .map((item) => {
                    'text': item['text'] as String,
                    'button_label': item['button_label'] as String,
                  })
              .toList(),
          'future': (suggestionsMap['future'] as List)
              .map((item) => {
                    'text': item['text'] as String,
                    'button_label': item['button_label'] as String,
                  })
              .toList(),
        };
      } else {
        throw Exception("Failed to load suggestions");
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
      return {'now': [], 'future': []};
    }
  }
}
