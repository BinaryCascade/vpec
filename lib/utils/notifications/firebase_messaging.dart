import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notifications.dart';

class AppFirebaseMessaging {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static void startListening() {
    getToken();

    FirebaseMessaging.onMessage.listen((message) {
      sendNotification(message);
    });
  }

  static void sendNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      LocalNotifications.flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            LocalNotifications.serverChannel.id,
            LocalNotifications.serverChannel.name,
            channelDescription: LocalNotifications.serverChannel.description,
            icon: '@drawable/ic_notification',
            shortcutId: 'action_schedule',
          ),
        ),
      );
    }
  }

  static Future<String> getToken() async {
    return await firebaseMessaging.getToken() ?? 'N/A';
  }
}
