import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ThemeHelper {
  /// return true, if system or user-chosen theme is dark
  static bool get isDarkMode {
    // get system theme
    var brightness = SchedulerBinding.instance.window.platformBrightness;
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

  /// Color StatusBar and SystemNavigationBar icons to current theme brightness
  static void colorSystemChrome({
    required ColoringMode mode,
  }) {
    Brightness brightness;
    switch (mode) {
      case ColoringMode.byCurrentTheme:
        brightness = isDarkMode ? Brightness.light : Brightness.dark;
        break;
      case ColoringMode.lightIcons:
        brightness = Brightness.light;
        break;
      case ColoringMode.darkIcons:
        brightness = Brightness.dark;
        break;
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: brightness,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
  }
}

/// This class store current [ThemeMode]
class ThemeNotifier with ChangeNotifier {
  ThemeMode themeMode;

  ThemeNotifier(this.themeMode);

  ThemeMode get getThemeMode => themeMode;

  void changeTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}

/// Coloring mode for status bar and system navigation icons
enum ColoringMode {
  /// Color system chrome based on current app theme
  byCurrentTheme,

  /// Color system chrome with light icons
  lightIcons,

  /// Color system chrome with dark icons
  darkIcons
}
