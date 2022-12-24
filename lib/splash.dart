import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

import 'screens/bottom_bar/bottom_bar_logic.dart';
import 'screens/login/login_screen.dart';
import 'utils/firebase_auth.dart';
import 'utils/hive_helper.dart';
import 'utils/theme_helper.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;

  const SplashScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FirebaseAppAuth appAuth;

  @override
  void initState() {
    appAuth = Provider.of<FirebaseAppAuth>(context, listen: false);
    _initApp();
    super.initState();
  }

  Future<void> _initApp() async {
    //make all our date in russian
    await initializeDateFormatting('ru');
    Intl.defaultLocale = 'ru';

    const QuickActions quickActions = QuickActions();

    if (appAuth.accountInfo.isLoggedIn) {
      // if app running on Android or iOS, make QuickActions
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        quickActions.initialize((shortcutType) {
          switch (shortcutType) {
            case 'action_news':
              context.read<BottomBarLogic>().setIndex(0);
              break;
            case 'action_announcements':
              context.read<BottomBarLogic>().setIndex(1);
              break;
            case 'action_schedule':
              context.read<BottomBarLogic>().setIndex(2);
              break;
            case 'action_map':
              context.read<BottomBarLogic>().setIndex(3);
              break;
          }
        });

        quickActions.setShortcutItems(<ShortcutItem>[
          const ShortcutItem(
            type: 'action_news',
            localizedTitle: 'События',
            icon: 'ic_news',
          ),
          const ShortcutItem(
            type: 'action_announcements',
            localizedTitle: 'Объявления',
            icon: 'ic_alerts',
          ),
          const ShortcutItem(
            type: 'action_schedule',
            localizedTitle: 'Расписание занятий',
            icon: 'ic_timetable',
          ),
          const ShortcutItem(
            type: 'action_map',
            localizedTitle: 'Карта кабинетов',
            icon: 'ic_maps',
          ),
        ]);
      }
      // open bottom bar index by setting "launch on start"
      if (HiveHelper.getValue('launchOnStart') != null) {
        int givenIndex = HiveHelper.getValue('launchOnStart');
        context.read<BottomBarLogic>().setIndex(givenIndex);
      }

      FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    } else {
      quickActions.clearShortcutItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome();

    return appAuth.accountInfo.isLoggedIn ? widget.child : const LoginScreen();
  }
}
