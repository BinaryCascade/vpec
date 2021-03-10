import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpec/splash.dart';
import 'package:vpec/ui/screens/bottom_bar_screen.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:vpec/ui/screens/settings_screen.dart';
import 'package:vpec/ui/theme.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness =
        schedule.SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return MaterialApp(
      theme: isDarkMode ? darkThemeData(context) : themeData(context),
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
