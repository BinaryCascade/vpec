import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpec/utils/theme_helper.dart';
import 'settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  static final routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, isTransparent: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        brightness: ThemeHelper().isDarkMode() ? Brightness.dark : Brightness.light,
      ),
      body: ListView(
        children: [
          buildAccountBlock(context),
          buildThemeChooser(context),
        ],
      ),
    );
  }
}
