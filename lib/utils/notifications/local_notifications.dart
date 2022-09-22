import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static const AndroidNotificationChannel serverChannel =
      AndroidNotificationChannel(
    'firebase_server_channel', // id
    'Уведомления с сервера', // title
    importance: Importance.max,
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(serverChannel);
  }
}
