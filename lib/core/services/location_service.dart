import 'package:geolocator/geolocator.dart';
import 'package:paketvault/core/errors/app_exception.dart';

class LocationData {
  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
  });
  final double latitude;
  final double longitude;
  final double accuracy;
  final DateTime timestamp;
}

class LocationService {
  const LocationService();

  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(
          'Layanan GPS tidak aktif. Aktifkan GPS di pengaturan perangkat.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException('Permission lokasi ditolak.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
          'Permission lokasi ditolak permanen. Buka Pengaturan.');
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      );
    } catch (e) {
      final last = await Geolocator.getLastKnownPosition();
      if (last == null) {
        throw LocationException('Gagal mendapatkan lokasi: $e');
      }
      return LocationData(
        latitude: last.latitude,
        longitude: last.longitude,
        accuracy: last.accuracy,
        timestamp: last.timestamp,
      );
    }
  }
}
