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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeHelper().isDarkMode() ? ThemeMode.dark : ThemeMode.light,
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
