import 'package:permission_handler/permission_handler.dart';
import 'package:paketvault/core/errors/app_exception.dart';

class PermissionService {
  const PermissionService();

  Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      throw const PermissionException(
          'Permission kamera ditolak permanen. Buka Pengaturan.');
    }
    return status.isGranted;
  }

  Future<bool> requestLocation() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isPermanentlyDenied) {
      throw const PermissionException(
          'Permission lokasi ditolak permanen. Buka Pengaturan.');
    }
    return status.isGranted;
  }

  Future<bool> isCameraGranted() async =>
      (await Permission.camera.status).isGranted;

  Future<bool> isLocationGranted() async =>
      (await Permission.locationWhenInUse.status).isGranted;

  Future<void> openSettings() async => openAppSettings();
}
