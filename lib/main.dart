import 'package:flutter/material.dart';
import 'package:vpec/splash.dart';
import 'package:vpec/ui/screens/bottom_bar_screen.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:vpec/ui/theme.dart';

void main() {
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
      },
    );
  }
}
