import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class DeviceDataService {
  Future<Map<String, dynamic>> getDeviceData() async {
    final dateTime = DateTime.now();
    final date = DateFormat('y-MM-dd').format(dateTime);
    final time = DateFormat('HH:mm:ss').format(dateTime);
    final dayOfWeek = DateFormat('EEEE').format(dateTime);

    String? location;
    String? coordinates;

    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final position = await Geolocator.getCurrentPosition();
        coordinates = "${position.latitude}, ${position.longitude}";

        // Получение адреса с помощью пакета geocoding
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          location = "${place.locality}, ${place.country}";
        }
      }
    } catch (e) {
      debugPrint("Failed to fetch location: $e");
    }

    return {
      'date': date,
      'time': time,
      'dayOfWeek': dayOfWeek,
      'coordinates': coordinates ?? 'Unknown',
      'location': location ?? 'Unknown',
    };
  }
}
