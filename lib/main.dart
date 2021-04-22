import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/theme.dart';
import 'utils/hive_helper.dart';
import 'utils/routes.dart';
import 'utils/theme_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper().initHive();
  await Firebase.initializeApp().whenComplete(() => runApp(
      ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(
              ThemeHelper().isDarkMode() ? ThemeMode.dark : ThemeMode.light),
          child: VPECApp())));
}

class VPECApp extends StatefulWidget {
  @override
  _VPECAppState createState() => _VPECAppState();
}

class _VPECAppState extends State<VPECApp> {
  @override
  void initState() {
    final window = WidgetsBinding.instance!.window;
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      setState(() {
        context.read<ThemeNotifier>().changeTheme(
            ThemeHelper().isDarkMode() ? ThemeMode.dark : ThemeMode.light);
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(),
      darkTheme: darkThemeData(),
      themeMode: context.watch<ThemeNotifier>().themeMode,
      initialRoute: '/',
      routes: Routes.map,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
    );
  }
}
