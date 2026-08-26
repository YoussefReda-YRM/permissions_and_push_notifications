import 'package:flutter/material.dart';
import 'package:fruites_hub_app/features/permissions/domain/entities/permissions_entity.dart';

Widget buildPermissionItem({
  required String title,
  required AppPermissionStatus status,
}) {
  return ListTile(
    title: Text(title),
    subtitle: Text(status.name),
    trailing: Icon(
      status == AppPermissionStatus.granted ? Icons.check_circle : Icons.cancel,
    ),
  );
}
