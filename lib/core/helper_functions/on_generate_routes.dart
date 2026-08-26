import 'package:flutter/material.dart';
import 'package:fruites_hub_app/core/utils/app_text_styles.dart';
import 'package:fruites_hub_app/features/home/presentation/views/home_view.dart';
import 'package:fruites_hub_app/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('الصفحة غير موجودة', style: TextStyles.bold16),
          ),
        ),
      );
  }
}
