import 'package:flutter/material.dart';
import 'package:vpec/splash.dart';
import 'package:vpec/ui/screens/bottom_bar_screen.dart';
import 'package:vpec/ui/screens/settings/settings_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> map = {
    '/': (context) => SplashScreen(child: BottomBarScreen()),
    '/home': (context) => BottomBarScreen(),
    '/settings': (context) => SettingsScreen(),
  };
}
