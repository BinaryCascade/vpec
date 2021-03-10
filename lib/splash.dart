import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:jiffy/jiffy.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  final Widget child;

  const SplashScreen({Key key, this.child}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initApp();
    super.initState();
  }

  void _loadingSettings() {
    var brightness =
        schedule.SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
          statusBarIconBrightness:
              isDarkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          systemNavigationBarIconBrightness:
              isDarkMode ? Brightness.light : Brightness.dark),
    );
  }

  Future<void> _initApp() async {
    //make all our date on russian
    await Jiffy.locale("ru");
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      auth.signInAnonymously();
    }

  }

  @override
  Widget build(BuildContext context) {
    _loadingSettings();
    return widget.child;
  }
}
