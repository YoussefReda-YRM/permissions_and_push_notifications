import 'package:dartz/dartz.dart';
import 'package:fruites_hub_app/features/permissions/domain/entities/permissions_entity.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/permission_service.dart';
import '../../domain/repos/permissions_repo.dart';

class PermissionsRepoImpl extends PermissionsRepo {
  final PermissionService permissionService;

  PermissionsRepoImpl({
    required this.permissionService,
  });

  @override
  Future<Either<Failure, PermissionEntity>> checkPermissions() async {
    try {
      final microphoneStatus =
          await permissionService.checkMicrophonePermission();

      final notificationStatus =
          await permissionService.checkNotificationPermission();

      final locationStatus =
          await permissionService.checkLocationPermission();

      return right(
        PermissionEntity(
          microphone: _mapPermissionStatus(microphoneStatus),
          notification: _mapPermissionStatus(notificationStatus),
          location: _mapPermissionStatus(locationStatus),
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ أثناء التحقق من الصلاحيات.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PermissionEntity>> requestPermissions() async {
    try {
      await permissionService.requestMicrophonePermission();

      await permissionService.requestNotificationPermission();

      await permissionService.requestLocationPermission();

      return await checkPermissions();
    } catch (e) {
      return left(
        ServerFailure(
          'حدث خطأ أثناء طلب الصلاحيات.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> openAppSettings() async {
    try {
      final result = await permissionService.openAppSettings();

      return right(result);
    } catch (e) {
      return left(
        ServerFailure(
          'تعذر فتح إعدادات التطبيق.',
        ),
      );
    }
  }

  AppPermissionStatus _mapPermissionStatus(
    PermissionStatus status,
  ) {
    switch (status) {
      case PermissionStatus.granted:
        return AppPermissionStatus.granted;

      case PermissionStatus.denied:
        return AppPermissionStatus.denied;

      case PermissionStatus.permanentlyDenied:
        return AppPermissionStatus.permanentlyDenied;

      case PermissionStatus.restricted:
        return AppPermissionStatus.restricted;

      case PermissionStatus.limited:
        return AppPermissionStatus.granted;

      case PermissionStatus.provisional:
        return AppPermissionStatus.granted;
    }
  }
}