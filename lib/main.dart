import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'ui/theme.dart';
import 'utils/hive_helper.dart';
import 'utils/routes/routes.dart';
import 'utils/theme_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // remove # from url path
  await HiveHelper().initHive();
  Firebase.initializeApp().whenComplete(() => runApp(
      ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(
              ThemeHelper.isDarkMode() ? ThemeMode.dark : ThemeMode.light),
          child: const VPECApp())));
}

class VPECApp extends StatefulWidget {
  const VPECApp({Key? key}) : super(key: key);

  @override
  _VPECAppState createState() => _VPECAppState();
}

class _VPECAppState extends State<VPECApp> {
  final router = FluroRouter();

  @override
  void initState() {
    Routes.defineRoutes(router);
    Routes.router = router;

    final window = WidgetsBinding.instance!.window;
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      setState(() {
        context.read<ThemeNotifier>().changeTheme(
            ThemeHelper.isDarkMode() ? ThemeMode.dark : ThemeMode.light);
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
      onGenerateRoute: Routes.router.generator,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
    );
  }
}
