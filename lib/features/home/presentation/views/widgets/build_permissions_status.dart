import 'package:flutter/material.dart';
import 'package:fruites_hub_app/features/home/presentation/views/widgets/build_permission_item.dart';
import 'package:fruites_hub_app/features/permissions/domain/entities/permissions_entity.dart';

Widget buildPermissionsStatus(PermissionEntity permissions) {
  return Column(
    children: [
      buildPermissionItem(title: 'Microphone', status: permissions.microphone),
      buildPermissionItem(
        title: 'Notifications',
        status: permissions.notification,
      ),
      buildPermissionItem(title: 'Location', status: permissions.location),
    ],
  );
}
