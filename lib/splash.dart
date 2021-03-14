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
      if (shortcutType == 'action_main') {
        print('The user tapped on the "Main view" action.');
      }
      // More handling code...
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'action_main', localizedTitle: 'Main view', icon: 'icon_main'),
      const ShortcutItem(type: 'action_help', localizedTitle: 'Help', icon: 'icon_help')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _loadingSettings();
    return widget.child;
  }
}
