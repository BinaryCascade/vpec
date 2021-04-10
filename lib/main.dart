import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'ui/theme.dart';
import 'utils/routes.dart';
import 'utils/theme_helper.dart';
import 'package:workmanager/workmanager.dart';

import 'utils/background_check.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Firebase.initializeApp().whenComplete(() => runApp(MyApp()));
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    BackgroundCheck().checkForLessons();
    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = ThemeHelper().isDarkMode();

  @override
  void initState() {
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      setState(() {
        isDarkTheme = ThemeHelper().isDarkMode();
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData(),
      darkTheme: darkThemeData(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: Routes.map,
    );
  }
}
