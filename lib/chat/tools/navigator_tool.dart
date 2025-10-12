import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'base_tool.dart';

class NavigatorTool extends BaseTool {
  @override
  String get name => 'NavigatorTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final String start = parameters['start'] as String;
    final String end = parameters['end'] as String;
    final String type = parameters['type'] as String;

    final String profile = _getProfile(type);
    final double speed = _getSpeed(type);

    final Future<Map<String, dynamic>> parsedData =
        _parseData(start, end, profile);

    final Future<String> infoString = parsedData.then((data) {
      final distance = data['distance'] as double;
      final durationInSeconds = (distance / speed).round();
      final durationInMinutes = (durationInSeconds / 60).round();

      final distanceKm = (distance / 1000).toStringAsFixed(1);
      final durationString = _formatDuration(durationInMinutes);

      return 'Расстояние: $distanceKm км, Время в пути: $durationString';
    });

    final String toolSummary =
        '<tool_summary>I have provided a map with navigation from $start to $end using $type</tool_summary>';

    return {
      'toolWidget': NavigatorToolWidget(
        parsedData: parsedData,
        profile: profile,
        infoString: infoString,
      ),
      'toolSummary': toolSummary,
    };
  }

  String _getProfile(String type) {
    switch (type.toLowerCase()) {
      case 'walking':
        return 'walking';
      case 'driver':
      case 'driving':
      default:
        return 'driving';
    }
  }

  double _getSpeed(String type) {
    switch (type.toLowerCase()) {
      case 'walking':
        return 5 / 3.6; // 5 km/h in m/s
      case 'driver':
      case 'driving':
      default:
        return 60 / 3.6; // 60 km/h in m/s
    }
  }

  Future<Map<String, dynamic>> _parseData(
      String start, String end, String profile) async {
    final startPoint = await _getCoordinates(start);
    final endPoint = await _getCoordinates(end);
    final routeData = await fetchRoute(startPoint, endPoint, profile);
    return {
      'start': startPoint,
      'end': endPoint,
      'route': routeData['route'],
      'distance': routeData['distance'],
    };
  }

  Future<LatLng> _getCoordinates(String input) async {
    if (input.contains(',')) {
      return _parseLatLng(input);
    } else {
      return await _geocodeAddress(input);
    }
  }

  LatLng _parseLatLng(String coordinates) {
    final parts = coordinates.split(',');
    return LatLng(double.parse(parts[0].trim()), double.parse(parts[1].trim()));
  }

  Future<LatLng> _geocodeAddress(String address) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(address)}&format=json&limit=1',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return LatLng(lat, lon);
      }
    }
    throw Exception('Failed to resolve address: $address');
  }

  Future<Map<String, dynamic>> fetchRoute(
      LatLng start, LatLng end, String profile) async {
    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/$profile/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=polyline',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final encodedPolyline = data['routes'][0]['geometry'] as String;
      final distance = data['routes'][0]['distance'] as double;
      return {
        'route': decodePolyline(encodedPolyline),
        'distance': distance,
      };
    } else {
      throw Exception('Failed to load route');
    }
  }

  List<LatLng> decodePolyline(String polyline) {
    final List<LatLng> result = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, resultLat = 0;
      int b;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        resultLat |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      final dlat = (resultLat & 1) != 0 ? ~(resultLat >> 1) : (resultLat >> 1);
      lat += dlat;

      shift = 0;
      int resultLng = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        resultLng |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      final dlng = (resultLng & 1) != 0 ? ~(resultLng >> 1) : (resultLng >> 1);
      lng += dlng;

      result.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return result;
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes мин';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return '**${hours} ч ${remainingMinutes} мин**';
    }
  }
}

class NavigatorToolWidget extends StatefulWidget {
  final Future<Map<String, dynamic>> parsedData;
  final String profile;
  final Future<String> infoString;

  const NavigatorToolWidget({
    Key? key,
    required this.parsedData,
    required this.profile,
    required this.infoString,
  }) : super(key: key);

  @override
  _NavigatorToolWidgetState createState() => _NavigatorToolWidgetState();
}

class _NavigatorToolWidgetState extends State<NavigatorToolWidget> {
  late final MapController _mapController;
  List<LatLng> _routePoints = [];
  LatLng? _startPoint;
  LatLng? _endPoint;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _loadRoute();
  }

  Future<void> _loadRoute() async {
    try {
      final data = await widget.parsedData;
      _startPoint = data['start'];
      _endPoint = data['end'];
      _routePoints = data['route'];

      // Вычисляем центр карты как среднее между начальной и конечной точкой
      if (_startPoint != null && _endPoint != null) {
        final centerLat = (_startPoint!.latitude + _endPoint!.latitude) / 2;
        final centerLng = (_startPoint!.longitude + _endPoint!.longitude) / 2;
        _mapController.move(
            LatLng(centerLat, centerLng), 10); // Устанавливаем масштаб
      }

      setState(() {});
    } catch (e) {
      print('Error loading route: $e');
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  List<Marker> _getMarkers() {
    if (_startPoint == null || _endPoint == null) return [];
    return [
      Marker(
        point: _startPoint!,
        width: 40,
        height: 40,
        child: Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
      Marker(
        point: _endPoint!,
        width: 40,
        height: 40,
        child: Icon(Icons.flag, color: Colors.green, size: 40),
      ),
    ];
  }

  PolylineLayer _getPolylineLayer() {
    return PolylineLayer(
      polylines: [
        Polyline(
          points: _routePoints,
          strokeWidth: 4.0,
          color: Colors.blue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<String>(
              future: widget.infoString,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Загрузка информации о маршруте...');
                } else if (snapshot.hasError) {
                  return Text('Ошибка загрузки информации: ${snapshot.error}');
                } else {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.navigator_tool',
                ),
                if (_routePoints.isNotEmpty) _getPolylineLayer(),
                MarkerLayer(
                  markers: _getMarkers(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
