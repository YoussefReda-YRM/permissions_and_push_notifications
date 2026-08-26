import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fruites_hub_app/core/services/local_notifications_service.dart';

class PushNotificationsService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Get FCM token
    final String? token = await _messaging.getToken();

    log('FCM Token: ${token ?? 'No token'}');

    // Background messages
    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );

    // Foreground messages
    _handleForegroundMessages();

    // Notification opened from background
    _handleMessageOpenedApp();

    // Notification opened from terminated state
    await _handleInitialMessage();
  }

  void _handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log(
          'Foreground notification: '
          '${message.notification?.title ?? 'No title'}',
        );

        LocalNotificationsService.showBasicNotification(message);
      },
    );
  }

  void _handleMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        log(
          'Notification opened from background: '
          '${message.notification?.title ?? 'No title'}',
        );

        // TODO:
        // Handle navigation / notification action here
        // after we see the rest of the project.
      },
    );
  }

  Future<void> _handleInitialMessage() async {
    final RemoteMessage? message =
        await _messaging.getInitialMessage();

    if (message == null) {
      return;
    }

    log(
      'Notification opened from terminated state: '
      '${message.notification?.title ?? 'No title'}',
    );

    // TODO:
    // Handle navigation / notification action here
    // after we see the rest of the project.
  }
}

/// Must remain a top-level function because Firebase
/// executes background handlers separately from the UI isolate.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  log(
    'Background notification: '
    '${message.notification?.title ?? 'No title'}',
  );
}