import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fruites_hub_app/features/permissions/domain/entities/permissions_entity.dart';

import '../../domain/repos/permissions_repo.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit(this.permissionsRepo)
      : super(const PermissionsInitial());

  final PermissionsRepo permissionsRepo;

  Future<void> checkPermissions() async {
    if (state is PermissionsLoading) return;

    emit(const PermissionsLoading());

    final result = await permissionsRepo.checkPermissions();

    result.fold(
      (failure) => emit(
        PermissionsFailure(
          message: failure.message,
        ),
      ),
      (permissionEntity) => emit(
        PermissionsSuccess(
          permissionEntity: permissionEntity,
        ),
      ),
    );
  }

  Future<void> requestPermissions() async {
    if (state is PermissionsLoading) return;

    emit(const PermissionsLoading());

    final result = await permissionsRepo.requestPermissions();

    result.fold(
      (failure) => emit(
        PermissionsFailure(
          message: failure.message,
        ),
      ),
      (permissionEntity) => emit(
        PermissionsSuccess(
          permissionEntity: permissionEntity,
        ),
      ),
    );
  }

  Future<void> checkAndRequestPermissions() async {
    if (state is PermissionsLoading) return;

    emit(const PermissionsLoading());

    final result = await permissionsRepo.checkPermissions();

    await result.fold(
      (failure) async {
        emit(
          PermissionsFailure(
            message: failure.message,
          ),
        );
      },
      (permissionEntity) async {
        final shouldRequest = _shouldRequestPermissions(
          permissionEntity,
        );

        if (!shouldRequest) {
          emit(
            PermissionsSuccess(
              permissionEntity: permissionEntity,
            ),
          );
          return;
        }

        final requestResult =
            await permissionsRepo.requestPermissions();

        requestResult.fold(
          (failure) => emit(
            PermissionsFailure(
              message: failure.message,
            ),
          ),
          (updatedPermissionEntity) => emit(
            PermissionsSuccess(
              permissionEntity: updatedPermissionEntity,
            ),
          ),
        );
      },
    );
  }

  bool _shouldRequestPermissions(
    PermissionEntity permissions,
  ) {
    return permissions.microphone == AppPermissionStatus.denied ||
        permissions.notification == AppPermissionStatus.denied ||
        permissions.location == AppPermissionStatus.denied;
  }

  Future<void> openAppSettings() async {
    final result = await permissionsRepo.openAppSettings();

    result.fold(
      (failure) => emit(
        PermissionsFailure(
          message: failure.message,
        ),
      ),
      (_) {},
    );
  }
}