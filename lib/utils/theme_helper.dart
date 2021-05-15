import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeHelper {
  /// return true, if system or user-chosen theme is dark
  static bool isDarkMode() {
    // get system theme
    var brightness =
        schedule.SchedulerBinding.instance!.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // get user-chosen theme
    Box settings = Hive.box('settings');
    if (settings.get('theme') != null) {
      settings.get('theme') == 'Тёмная тема'
          ? isDarkMode = true
          : isDarkMode = false;
    }

    return isDarkMode;
  }

  /// [haveAppbar] = set to true if you use AppBar in page
  static void colorStatusBar(
      {required BuildContext context, required bool haveAppbar}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: haveAppbar
              ? Colors.transparent
              : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
          statusBarIconBrightness:
              isDarkMode() ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: haveAppbar
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          systemNavigationBarIconBrightness:
              isDarkMode() ? Brightness.light : Brightness.dark),
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeMode themeMode;

  ThemeNotifier(this.themeMode);

  ThemeMode get getThemeMode => themeMode;

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}
