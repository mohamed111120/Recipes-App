import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_service.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    messaging.requestPermission();
    String? token = await messaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );
    });
  }

  static Future<void> handlerBackgroundMessage(RemoteMessage message) async {
    Firebase.initializeApp();
  }
}
