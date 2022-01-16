import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

import 'screens/bottom_bar/bottom_bar_logic.dart';
import 'screens/login/login_screen.dart';
import 'screens/settings/settings_logic.dart';
import 'utils/hive_helper.dart';
import 'utils/theme_helper.dart';

class SplashScreen extends StatefulWidget {
  final Widget child;

  const SplashScreen({Key? key, required this.child}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userCompleteLoginPage = !(HiveHelper.getValue('isUserEntrant') == null ||
      SettingsLogic.getAccountMode() == UserMode.entrant);

  @override
  void initState() {
    _initApp();
    super.initState();
  }

  Future<void> _initApp() async {
    //make all our date in russian
    await initializeDateFormatting('ru');
    Intl.defaultLocale = 'ru';

    if (userCompleteLoginPage) {
      // if app running on Android or iOS, make QuickActions
      if (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) {
        const QuickActions quickActions = QuickActions();
        quickActions.initialize((shortcutType) {
          switch (shortcutType) {
            case 'action_news':
              context.read<BottomBarLogic>().setIndex(0);
              break;
            case 'action_alerts':
              context.read<BottomBarLogic>().setIndex(1);
              break;
            case 'action_timetable':
              context.read<BottomBarLogic>().setIndex(2);
              break;
            case 'action_schedule':
              context.read<BottomBarLogic>().setIndex(3);
              break;
          }
        });

        quickActions.setShortcutItems(<ShortcutItem>[
          const ShortcutItem(
              type: 'action_news', localizedTitle: 'События', icon: 'ic_news'),
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
      if (HiveHelper.getValue('launchOnStart') != null) {
        int? givenIndex = HiveHelper.getValue('launchOnStart');
        context.read<BottomBarLogic>().setIndex(givenIndex!);
      }
    } else {
      const QuickActions quickActions = QuickActions();
      quickActions.clearShortcutItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: false);
    return userCompleteLoginPage ? widget.child : const LoginScreen();
  }
}
