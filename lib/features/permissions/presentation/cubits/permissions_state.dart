part of 'permissions_cubit.dart';

@immutable
sealed class PermissionsState {
  const PermissionsState();
}

final class PermissionsInitial extends PermissionsState {
  const PermissionsInitial();
}

final class PermissionsLoading extends PermissionsState {
  const PermissionsLoading();
}

final class PermissionsSuccess extends PermissionsState {
  final PermissionEntity permissionEntity;

  const PermissionsSuccess({
    required this.permissionEntity,
  });
}

final class PermissionsFailure extends PermissionsState {
  final String message;

  const PermissionsFailure({
    required this.message,
  });
}