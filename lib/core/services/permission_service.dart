import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

class PermissionService {
  Future<permission_handler.PermissionStatus>
      checkMicrophonePermission() {
    return permission_handler.Permission.microphone.status;
  }

  Future<permission_handler.PermissionStatus>
      requestMicrophonePermission() {
    return permission_handler.Permission.microphone.request();
  }

  Future<permission_handler.PermissionStatus>
      checkNotificationPermission() {
    return permission_handler.Permission.notification.status;
  }

  Future<permission_handler.PermissionStatus>
      requestNotificationPermission() {
    return permission_handler.Permission.notification.request();
  }

  Future<permission_handler.PermissionStatus>
      checkLocationPermission() {
    return permission_handler.Permission.location.status;
  }

  Future<permission_handler.PermissionStatus>
      requestLocationPermission() {
    return permission_handler.Permission.location.request();
  }

  Future<bool> openAppSettings() {
    return permission_handler.openAppSettings();
  }
}