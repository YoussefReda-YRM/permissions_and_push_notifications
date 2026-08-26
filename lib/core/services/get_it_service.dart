import 'package:get_it/get_it.dart';

import 'package:fruites_hub_app/core/services/permission_service.dart';
import 'package:fruites_hub_app/core/services/push_notifications_service.dart';
import 'package:fruites_hub_app/features/permissions/data/repos/permissions_repo_impl.dart';
import 'package:fruites_hub_app/features/permissions/domain/repos/permissions_repo.dart';
import 'package:fruites_hub_app/features/permissions/presentation/cubits/permissions_cubit.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<PermissionService>(
    PermissionService(),
  );

  getIt.registerSingleton<PermissionsRepo>(
    PermissionsRepoImpl(
      permissionService: getIt<PermissionService>(),
    ),
  );

  getIt.registerFactory<PermissionsCubit>(
    () => PermissionsCubit(
      getIt<PermissionsRepo>(),
    ),
  );

  getIt.registerSingleton<PushNotificationsService>(
    PushNotificationsService(),
  );
}