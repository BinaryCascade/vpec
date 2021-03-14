import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpec/ui/widgets/styled_widgets.dart';
import 'package:vpec/utils/icons.dart';
import 'settings_logic.dart';

// Two ListTiles for account management
Widget buildAccountBlock(BuildContext context) {
  return Column(
    children: [
      ListTile(
        onTap: () => SettingsLogic().accountLogin(context),
        leading: Container(
          height: double.infinity,
          child: Icon(
            Icons.account_circle_outlined,
            color: Theme.of(context).accentColor,
            size: 32,
          ),
        ),
        title: Text(
          'Аккаунт',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Text(
          SettingsLogic().getAccountEmail(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      ListTile(
        onTap: () => SettingsLogic().changeName(context),
        leading: Icon(
          Icons.edit_outlined,
          color: Theme.of(context).accentColor,
          size: 32,
        ),
        title: Text(
          'Имя',
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(keys: ['username']),
          builder: (context, box, child) {
            return Text(
              box.get('username', defaultValue: 'Изменить имя'),
              style: Theme.of(context).textTheme.subtitle1,
            );
          },
        ),
      ),
    ],
  );
}

Widget buildThemeChooser(BuildContext context) {
  return hivedListTile(
    context: context,
    title: 'Тема приложения',
    subtitleKey: 'theme',
    defaultValue: 'Системная тема',
    icon: Icon(
      VEKiconPack.battery_saver_line,
      size: 32,
      color: Theme.of(context).accentColor,
    ),
    onTap: () async {
      SettingsLogic().chooseTheme(context);
    },
  );
}
