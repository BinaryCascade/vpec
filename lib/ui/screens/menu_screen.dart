import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'settings/settings_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'Настройки',
              style: Theme.of(context).textTheme.headline3,
            ),
            subtitle: Text('Изменить имя, тему, стартовый экран'),
            leading: Container(
              height: double.infinity,
              child: Icon(Icons.settings_outlined,
                  color: Theme.of(context).accentColor, size: 32),
            ),
            onTap: () async {
              await Navigator.pushNamed(context, SettingsScreen.routeName);
              var brightness =
                  schedule.SchedulerBinding.instance.window.platformBrightness;
              bool isDarkMode = brightness == Brightness.dark;

              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                    statusBarColor: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.7),
                    statusBarIconBrightness:
                        isDarkMode ? Brightness.light : Brightness.dark,
                    systemNavigationBarColor: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                    systemNavigationBarIconBrightness:
                        isDarkMode ? Brightness.light : Brightness.dark),
              );
            },
          ),
        ],
      ),
    );
  }
}
