import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:fruites_hub_app/core/helper_functions/on_generate_routes.dart';
import 'package:fruites_hub_app/core/services/custom_bloc_observer.dart';
import 'package:fruites_hub_app/core/services/get_it_service.dart';
import 'package:fruites_hub_app/core/services/local_notifications_service.dart';
import 'package:fruites_hub_app/core/services/push_notifications_service.dart';
import 'package:fruites_hub_app/core/utils/app_colors.dart';
import 'package:fruites_hub_app/features/splash/presentation/views/splash_view.dart';
import 'package:fruites_hub_app/firebase_options.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Dependency Injection
  setupGetit();

  // Bloc observer
  Bloc.observer = CustomBlocObserver();

  // Local notifications must be initialized
  // before starting Firebase Messaging listeners.
  await LocalNotificationsService.init();

  // Firebase Messaging
  await getIt<PushNotificationsService>().init();
  runApp(const FruitsHub());
}

class FruitsHub extends StatelessWidget {
  const FruitsHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
      debugShowCheckedModeBanner: false,
      
    );
  }
}
