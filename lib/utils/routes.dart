import 'package:flutter/material.dart';
import 'package:vpec/splash.dart';
import 'package:vpec/ui/screens/admin_screen.dart';
import 'package:vpec/ui/screens/about_app_screen.dart';
import 'package:vpec/ui/screens/bottom_bar_screen.dart';
import 'package:vpec/ui/screens/cabinets_map_screen.dart';
import 'package:vpec/ui/screens/settings/settings_screen.dart';
import 'package:vpec/ui/screens/teacher_screen.dart';
import 'package:vpec/ui/screens/view_document.dart';

class Routes {
  static final Map<String, WidgetBuilder> map = {
    '/': (context) => SplashScreen(child: BottomBarScreen()),
    '/home': (context) => BottomBarScreen(),
    '/settings': (context) => SettingsScreen(),
    '/document': (context) => DocumentViewScreen(),
    '/cabinets': (context) => CabinetsMapScreen(),
    '/administration': (context) => AdminScreen(),
    '/teacher': (context) => TeacherScreen(),
    '/about': (context) => AboutAppScreen(),
  };
}
