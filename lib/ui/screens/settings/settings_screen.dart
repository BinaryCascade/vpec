import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:vpec/ui/screens/settings/setting_ui.dart';

class SettingsScreen extends StatefulWidget {
  static final routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness =
        schedule.SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      body: ListView(
        children: [
          buildAccountBlock(context),
        ],
      ),
    );
  }
}
