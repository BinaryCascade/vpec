import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeHelper {
  bool isDarkMode() {
    // get system theme
    var brightness =
        schedule.SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // get user-chosen theme
    Box settings = Hive.box('settings');
    if (settings.get('theme') != null) {
      settings.get('theme') == 'dark' ? isDarkMode = true : isDarkMode = false;
    }

    return isDarkMode;
  }

  void colorStatusBar({@required BuildContext context, @required bool isTransparent}) {
    // [isTransparent] = true if you use AppBar in page
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: isTransparent
              ? Colors.transparent
              : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
          statusBarIconBrightness:
              isDarkMode() ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: isTransparent
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          systemNavigationBarIconBrightness:
              isDarkMode() ? Brightness.light : Brightness.dark),
    );
  }
}
