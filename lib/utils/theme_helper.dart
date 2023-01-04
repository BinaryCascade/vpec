import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import 'utils.dart';

class ThemeHelper {
  /// return true, if system or user-chosen theme is dark
  static bool get isDarkMode {
    // get system theme
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    // get user-chosen theme
    Box settings = Hive.box('settings');
    if (settings.get('theme') != null) {
      settings.get('theme') == 'Тёмная тема' ? isDarkMode = true : isDarkMode = false;
    }

    return isDarkMode;
  }

  static void doInitialChrome() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
  }

  static SystemUiOverlayStyle overlayStyleHelper(Color legacyColor) {
    if (AndroidSdkVersion.version < 29) {
      // less than Android 10
      return SystemUiOverlayStyle(systemNavigationBarColor: legacyColor);
    }

    return const SystemUiOverlayStyle();
  }

  /// Color StatusBar and SystemNavigationBar icons to current theme brightness
  static void colorSystemChrome({
    ColoringMode mode = ColoringMode.byCurrentTheme,
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

  void changeTheme(ThemeMode mode) {
    FirebaseAnalytics.instance.logEvent(name: 'theme_changed', parameters: {
      'theme_mode_used': mode,
    });

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
