import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quick_actions/quick_actions.dart';

import 'utils/theme_helper.dart';

class SplashScreen extends StatefulWidget {
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
    ThemeHelper().colorStatusBar(context: context, isTransparent: false);
  }

  Future<void> _initApp() async {
    //make all our date on russian
    await Jiffy.locale("ru");
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      auth.signInAnonymously();
    }

    // TODO: сделать шорткаты
    final QuickActions quickActions = QuickActions();
    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'action_timetable':
          Navigator.popAndPushNamed(context, '/', arguments: 2);
          break;
        case 'action_schedule':
          Navigator.popAndPushNamed(context, '/', arguments: 3);
          break;
        default:
          Navigator.popAndPushNamed(context, '/', arguments: null);
          break;
      }
      // More handling code...
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'action_timetable', localizedTitle: 'Звонки', icon: 'icon_main'),
      const ShortcutItem(type: 'action_schedule', localizedTitle: 'Расписание', icon: 'icon_help')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _loadingSettings();
    return widget.child;
  }
}
