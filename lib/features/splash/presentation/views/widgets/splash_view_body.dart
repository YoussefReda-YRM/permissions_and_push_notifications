import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruites_hub_app/core/utils/app_images.dart';
import 'package:fruites_hub_app/features/home/presentation/views/home_view.dart';
import 'package:svg_flutter/svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _startNavigationTimer();
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(Assets.imagesPlant),
          ],
        ),
        SvgPicture.asset(Assets.imagesLogo),
        SvgPicture.asset(
          Assets.imagesSplashBottom,
          fit: BoxFit.fill,
        ),
      ],
    );
  }

  void _startNavigationTimer() {
    _navigationTimer = Timer(
      const Duration(seconds: 3),
      _navigateToHome,
    );
  }

  void _navigateToHome() {
    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      HomeView.routeName,
    );
  }
}