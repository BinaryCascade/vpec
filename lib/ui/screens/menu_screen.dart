import 'package:flutter/material.dart';
import 'package:vpec/utils/theme_helper.dart';
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
            subtitle: Text(
              'Изменить имя, тему, стартовый экран',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            leading: Container(
              height: double.infinity,
              child: Icon(Icons.settings_outlined,
                  color: Theme.of(context).accentColor, size: 32),
            ),
            onTap: () async {
              await Navigator.pushNamed(context, SettingsScreen.routeName);
              ThemeHelper().colorStatusBar(context: context, isTransparent: false);
            },
          ),
        ],
      ),
    );
  }
}
