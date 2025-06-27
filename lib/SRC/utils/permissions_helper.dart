import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();

  factory PermissionService() {
    return _instance;
  }

  PermissionService._internal();

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<bool> checkAndRequestPermissions() async {
    // Request Location permission
    final locationStatus = await Permission.location.request();
    if (!locationStatus.isGranted) {
      return false;
    }
    // Request camera permission
    final cameraStatus = await requestCameraPermission();
    if (!cameraStatus) {
      return false;
    }

    return true;
  }

  Future<bool> checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final microphoneStatus = await Permission.microphone.status;
    final notificationStatus = await Permission.notification.status;
    final storageStatus = await Permission.storage.status;

    return cameraStatus.isGranted &&
        microphoneStatus.isGranted &&
        notificationStatus.isGranted &&
        storageStatus.isGranted;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
