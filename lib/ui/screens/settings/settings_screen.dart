import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpec/ui/widgets/styled_widgets.dart';
import 'package:vpec/utils/theme_helper.dart';
import 'settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        brightness:
            ThemeHelper().isDarkMode() ? Brightness.dark : Brightness.light,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: buildAccountBlock(context)),
          buildThemeChooser(context),
          buildLaunchOnStartChooser(context),
          // buildBackgroundTaskWidgets(context), // low-priority
          Divider(),
          styledListTile(
              context: context,
              icon: Icon(
                Icons.info_outlined,
                size: 32,
                color: Theme.of(context).accentColor,
              ),
              title: 'О приложении',
              subtitle: 'Просмотреть техническую информацию',
              onTap: () => Navigator.pushNamed(context, '/about')),
        ],
      ),
    );
  }
}
