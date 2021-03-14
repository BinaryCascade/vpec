import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpec/splash.dart';
import 'package:vpec/ui/screens/bottom_bar_screen.dart';
import 'package:vpec/ui/theme.dart';
import 'package:vpec/utils/theme_helper.dart';

import 'ui/screens/settings/settings_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MyApp());
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
      Box settings = Hive.box('settings');
      // This callback gets invoked every time brightness changes
      setState(() {
        if (settings.get('theme') == null) {
          isDarkTheme = window.platformBrightness == Brightness.dark;
        } else {
          isDarkTheme = ThemeHelper().isDarkMode();
        }
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData(context),
      darkTheme: darkThemeData(context),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) =>
            SplashScreen(child: BottomBarScreen()),
        BottomBarScreen.routeName: (context) => BottomBarScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
      },
    );
  }
}
