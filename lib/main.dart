import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import '/utils/utils.dart';
import 'theme.dart';
import 'utils/firebase_auth.dart';
import 'utils/hive_helper.dart';
import 'utils/notifications/firebase_messaging.dart';
import 'utils/notifications/local_notifications.dart';
import 'utils/routes/routes.dart';
import 'utils/theme_helper.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // remove # from url path
  await useHttpOverrides();
  await HiveHelper().initHive();
  await Firebase.initializeApp();
  await LocalNotifications.initializeNotifications();
  AppFirebaseMessaging.startListening();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FirebaseAppAuth()),
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(
          ThemeHelper.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        ),
      ),
    ],
    child: const VPECApp(),
  ));
}

class VPECApp extends StatefulWidget {
  const VPECApp({Key? key}) : super(key: key);

  @override
  State<VPECApp> createState() => _VPECAppState();
}

class _VPECAppState extends State<VPECApp> {
  final router = FluroRouter();

  @override
  void initState() {
    Routes.defineRoutes(router);
    Routes.router = router;

    Provider.of<FirebaseAppAuth>(context, listen: false).startListening();

    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      // This callback gets invoked every time brightness changes
      setState(() {
        context.read<ThemeNotifier>().changeTheme(
              ThemeHelper.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            );
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      theme: themeData(),
      darkTheme: darkThemeData(),
      navigatorKey: navigatorKey,
      themeMode: context.watch<ThemeNotifier>().themeMode,
      initialRoute: '/',
      onGenerateRoute: Routes.router.generator,
      debugShowCheckedModeBanner: false,
    );
  }
}
