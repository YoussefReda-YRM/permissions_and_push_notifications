enum AppPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  unavailable,
}

class PermissionEntity {
  final AppPermissionStatus microphone;
  final AppPermissionStatus notification;
  final AppPermissionStatus location;

  const PermissionEntity({
    required this.microphone,
    required this.notification,
    required this.location,
  });
}