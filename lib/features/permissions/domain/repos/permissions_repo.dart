import 'package:dartz/dartz.dart';
import 'package:fruites_hub_app/core/errors/failures.dart';
import 'package:fruites_hub_app/features/permissions/domain/entities/permissions_entity.dart';

abstract class PermissionsRepo {
  Future<Either<Failure, PermissionEntity>> requestPermissions();

  Future<Either<Failure, PermissionEntity>> checkPermissions();

  Future<Either<Failure, bool>> openAppSettings();
}
