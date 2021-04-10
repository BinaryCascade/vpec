import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quick_actions/quick_actions.dart';
import 'utils/hive_helper.dart';

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
    ThemeHelper().colorStatusBar(context: context, haveAppbar: false);
  }

  Future<void> _initApp() async {
    //make all our date on russian
    await Jiffy.locale("ru");

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      auth.signInAnonymously();
    }

    // if app running on Android or iOS, make QuickActions
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final QuickActions quickActions = QuickActions();
      quickActions.initialize((shortcutType) {
        switch (shortcutType) {
          case 'action_news':
            Navigator.popAndPushNamed(context, '/home', arguments: 0);
            break;
          case 'action_alerts':
            Navigator.popAndPushNamed(context, '/home', arguments: 1);
            break;
          case 'action_timetable':
            Navigator.popAndPushNamed(context, '/home', arguments: 2);
            break;
          case 'action_schedule':
            Navigator.popAndPushNamed(context, '/home', arguments: 3);
            break;
        }
      });

      quickActions.setShortcutItems(<ShortcutItem>[
        const ShortcutItem(
            type: 'action_news', localizedTitle: 'Новости', icon: 'ic_news'),
        const ShortcutItem(
            type: 'action_alerts',
            localizedTitle: 'Объявления',
            icon: 'ic_alerts'),
        const ShortcutItem(
            type: 'action_timetable',
            localizedTitle: 'Звонки',
            icon: 'ic_timetable'),
        const ShortcutItem(
            type: 'action_schedule',
            localizedTitle: 'Расписание',
            icon: 'ic_schedule')
      ]);
    }
    // open bottom bar index by setting "launch on start"
    if (HiveHelper().getValue('launchOnStart') != null) {
      int givenIndex = HiveHelper().getValue('launchOnStart');
      Navigator.popAndPushNamed(context, '/home', arguments: givenIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadingSettings();
    return widget.child;
  }
}
