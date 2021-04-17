import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/theme.dart';
import 'utils/hive_helper.dart';
import 'utils/routes.dart';
import 'utils/theme_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper().initHive();
  await Firebase.initializeApp().whenComplete(() => runApp(VPECApp()));
}

class VPECApp extends StatefulWidget {
  @override
  _VPECAppState createState() => _VPECAppState();
}

class _VPECAppState extends State<VPECApp> {
  bool isDarkTheme = ThemeHelper().isDarkMode();

  @override
  void initState() {
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      setState(() {
        isDarkTheme = ThemeHelper().isDarkMode();
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData(),
      darkTheme: darkThemeData(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: Routes.map,
    );
  }
}
