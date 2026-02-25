import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'base_tool.dart';

class WeatherTool extends BaseTool {
  @override
  String get name => 'WeatherTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final location = parameters['location'] as String;
    final units = parameters['units'] as String;
    final language = parameters['language'] as String;
    final apiKey = '70fb5d8276e0d1732dfbe56baab01dd3';

    // Создаем toolSummary
    final String toolSummary = '<tool_summary>I have provided weather information for the location: $location using $units units and $language language</tool_summary>';

    // Возвращаем Map с toolWidget и toolSummary
    return {
      'toolWidget': WeatherToolWidget(
        initialLocation: location,
        units: units,
        language: language,
        apiKey: apiKey,
      ),
      'toolSummary': toolSummary,
    };
  }
}

class WeatherToolWidget extends StatefulWidget {
  final String initialLocation;
  final String units;
  final String language;
  final String apiKey;

  const WeatherToolWidget({
    Key? key,
    required this.initialLocation,
    required this.units,
    required this.language,
    required this.apiKey,
  }) : super(key: key);

  @override
  _WeatherToolWidgetState createState() => _WeatherToolWidgetState();
}

class _WeatherToolWidgetState extends State<WeatherToolWidget> {
  late TextEditingController _locationController;
  String _weatherInfo = 'Loading...';
  String _description = '';
  String _temperature = '';
  String _feelsLike = '';
  int _humidity = 0;
  double _windSpeed = 0.0;
  String _weatherEmoji = '';

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: widget.initialLocation);
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    // Отображаем "Loading..." пока загружаются новые данные
    setState(() {
      _weatherInfo = 'Loading...';
    });

    final location = _locationController.text;
    final baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
    final url = Uri.parse(
        '$baseUrl?q=${Uri.encodeComponent(location)}&units=${widget.units}&lang=${widget.language}&appid=${widget.apiKey}');

    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        setState(() {
          _parseWeatherData(weatherData);
        });
      } else {
        setState(() {
          _weatherInfo = 'Failed to load weather data: ${response.statusCode}';
        });
      }
    } on TimeoutException catch (e) {
      setState(() {
        _weatherInfo = 'The request timed out while trying to connect to the server.';
      });
    } on http.ClientException catch (e) {
      setState(() {
        _weatherInfo = 'Client error occurred: $e';
      });
    } catch (e) {
      setState(() {
        _weatherInfo = 'Other error occurred: $e';
      });
    }
  }

  void _parseWeatherData(Map<String, dynamic> data) {
    _description = data['weather'][0]['description'];
    _temperature = data['main']['temp'].toString();
    _feelsLike = data['main']['feels_like'].toString();
    _humidity = data['main']['humidity'];
    _windSpeed = data['wind']['speed'];

    _weatherEmoji = _getWeatherEmoji(_description);
    _weatherInfo = '';  // Очищаем сообщение "Loading..." когда данные загружены
  }

  String _getWeatherEmoji(String description) {
    description = description.toLowerCase();
    if (description.contains('clear') || description.contains('ясно')) {
      return '☀️';
    } else if (description.contains('clouds') || description.contains('облачно')) {
      return '☁️';
    } else if (description.contains('rain') || description.contains('дождь')) {
      return '🌧️';
    } else if (description.contains('snow') || description.contains('снег')) {
      return '❄️';
    } else if (description.contains('thunderstorm') || description.contains('гроза')) {
      return '⛈️';
    } else if (description.contains('mist') || description.contains('fog') || 
              description.contains('туман')) {
      return '🌫️';
    } else {
      return '🌡️';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final iconSize = screenSize.width * 0.25;
    final textFontSize = screenSize.width * 0.05;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onTapOutside: (_) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Город',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
              onSubmitted: (value) {
                _fetchWeather();
              },
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Обновить'),
            ),
            SizedBox(height: 20.0),
            if (_weatherInfo.isNotEmpty)
              Text(
                _weatherInfo,
                style: TextStyle(fontSize: textFontSize),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _description,
                    style: TextStyle(
                      fontSize: textFontSize * 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _weatherEmoji,
                    style: TextStyle(fontSize: iconSize),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Температура: $_temperature°C',
                    style: TextStyle(fontSize: textFontSize),
                  ),
                  Text(
                    'Ощущается как: $_feelsLike°C',
                    style: TextStyle(fontSize: textFontSize * 0.8, color: Colors.grey),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildWindSpeedWidget(iconSize, textFontSize),
                      _buildHumidityWidget(iconSize, textFontSize),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWindSpeedWidget(double iconSize, double textFontSize) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'Скорость ветра',
            style: TextStyle(fontSize: textFontSize * 0.5), // Уменьшено в 2 раза
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.air, size: iconSize * 0.5),
              SizedBox(width: 8.0),
              Text(
                '$_windSpeed м/с',
                style: TextStyle(fontSize: textFontSize),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: _windSpeed / 20.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorTween(
                begin: Colors.green,
                end: Colors.red,
              ).evaluate(AlwaysStoppedAnimation(_windSpeed / 20.0))!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHumidityWidget(double iconSize, double textFontSize) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'Влажность',
            style: TextStyle(fontSize: textFontSize * 0.5), // Уменьшено в 2 раза
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.opacity, size: iconSize * 0.5),
              SizedBox(width: 8.0),
              Text(
                '$_humidity%',
                style: TextStyle(fontSize: textFontSize),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: _humidity / 100.0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorTween(
                begin: Color(0xFFFFE4B5), // Бежевый
                end: Colors.blue,
              ).evaluate(AlwaysStoppedAnimation(_humidity / 100.0))!,
            ),
          ),
        ],
      ),
    );
  }
}