import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../splash.dart';
import '../ui/screens/about_app/about_app_screen.dart';
import '../ui/screens/admins_screen.dart';
import '../ui/screens/bottom_bar/bottom_bar_logic.dart';
import '../ui/screens/bottom_bar/bottom_bar_screen.dart';
import '../ui/screens/cabinets_map/cabinets_map_logic.dart';
import '../ui/screens/cabinets_map/cabinets_map_screen.dart';
import '../ui/screens/documents_screen.dart';
import '../ui/screens/job_quiz/job_quiz_screen.dart';
import '../ui/screens/settings/settings_screen.dart';
import '../ui/screens/teachers_screen.dart';
import '../ui/screens/view_document.dart';

class Routes {
  static final Map<String, WidgetBuilder> map = {
    '/': (context) => ChangeNotifierProvider(
        create: (_) => BottomBarLogic(),
        child: SplashScreen(child: BottomBarScreen())),
    '/home': (context) => BottomBarScreen(),
    '/settings': (context) => SettingsScreen(),
    '/view_document': (context) => DocumentViewScreen(),
    '/cabinets': (context) => ChangeNotifierProvider(
        create: (_) => CabinetsMapLogic(), child: CabinetsMapScreen()),
    '/administration': (context) => AdminScreen(),
    '/teacher': (context) => TeacherScreen(),
    '/about': (context) => AboutAppScreen(),
    '/job_quiz': (context) => JobQuizScreen(),
    '/documents': (context) => DocumentsScreen(),
  };
}
