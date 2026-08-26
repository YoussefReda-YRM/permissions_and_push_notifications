import 'package:flutter/material.dart';
import 'package:fruites_hub_app/core/utils/app_images.dart';
import 'package:fruites_hub_app/core/utils/app_text_styles.dart';

import '../../../../../core/widgets/notification_widget.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      trailing: const NotificationWidget(),
      leading: Image.asset(Assets.imagesProfileImage),
      title: Text(
        'صباح الخير !..',
        textAlign: TextAlign.right,
        style: TextStyles.regular16.copyWith(color: const Color(0xFF949D9E)),
      ),
      subtitle: Text(
        "يوسف رضا محمد",
        textAlign: TextAlign.right,
        style: TextStyles.bold16,
      ),
    );
  }
}
