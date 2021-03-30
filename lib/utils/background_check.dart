import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'hive_helper.dart';
import 'package:xml/xml.dart';

class BackgroundCheck {
  String baseUrl = 'http://energocollege.ru/vec_assistant/'
      '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/';
  String endUrl = '.jpg';

  String getUrl() {
    // get next day to show lesson schedule
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('d-M-yyyy');

    int _plusDays = 0;
    int today = date.weekday;
    switch (today) {
      case DateTime.friday:
        _plusDays = 3;
        break;
      case DateTime.saturday:
        _plusDays = 2;
        break;
      case DateTime.sunday:
        _plusDays = 1;
        break;
      default:
        _plusDays = 1;
        break;
    }

    date = date.add(Duration(days: _plusDays));

    return baseUrl + formatter.format(date) + endUrl;
  }

  Future<void> checkForLessons() async {
    bool hasConnection = await DataConnectionChecker().hasConnection;
    if (hasConnection) {
      var response = await http.get(Uri.parse(getUrl()));
      var responseBody = XmlDocument.parse(response.body);
      try {
        var newResponseBody = responseBody.outerXml.substring(
            responseBody.outerXml.indexOf('<h1>') + 4,
            responseBody.outerXml.indexOf('</h1>'));
        if (newResponseBody == 'Not Found') {
          print('Расписание не найдено');
        }
      } catch (_) {
        print('Найдено расписание на след.день!');
        String lastUrl = HiveHelper().getValue('lastUrl');
        if (lastUrl != getUrl()) {
          showNotification('Расписание занятий',
              "Найдено новое расписание занятий на завтра");
          HiveHelper().saveValue(key: 'lastUrl', value: getUrl());
        }
      }
    } else {
      print('No internet, skip check. Reason:');
      print(DataConnectionChecker().lastTryResults);
    }
  }
  // for future: move notifications to other file,
  // when making Firebase Cloud Messaging
  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = AndroidInitializationSettings(
        'ic_notification'); // <- default icon name is @mipmap/ic_launcher
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'background_notifications',
        'Фоновые проверки',
        'Уведомления о найденном расписании и прочее',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future onSelectNotification(String payload) async {}
}
