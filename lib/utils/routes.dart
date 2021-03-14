import 'package:flutter/material.dart';
import 'package:vpec/splash.dart';
import 'package:vpec/ui/screens/bottom_bar_screen.dart';
import 'package:vpec/ui/screens/settings/settings_screen.dart';
import 'package:vpec/ui/screens/view_document.dart';

class Routes {
  static final Map<String, WidgetBuilder> map = {
    '/': (context) => SplashScreen(child: BottomBarScreen()),
    '/home': (context) => BottomBarScreen(),
    '/settings': (context) => SettingsScreen(),
    '/document': (context) => DocumentViewScreen(),
  };
}
