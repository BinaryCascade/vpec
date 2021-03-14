import 'package:flutter/material.dart';
import 'package:vpec/ui/widgets/styled_widgets.dart';
import 'package:vpec/utils/icons.dart';
import 'settings_logic.dart';

// Two ListTiles for account management
Widget buildAccountBlock(BuildContext context) {
  return Column(
    children: [
      styledListTile(
        context: context,
        onTap: () => SettingsLogic().accountLogin(context),
        icon: Icon(
          Icons.account_circle_outlined,
          color: Theme.of(context).accentColor,
          size: 32,
        ),
        title: 'Аккаунт',
        subtitle: SettingsLogic().getAccountEmail(),
      ),
      hivedListTile(
          context: context,
          onTap: () => SettingsLogic().changeName(context),
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).accentColor,
            size: 32,
          ),
          title: 'Имя',
          subtitleKey: 'username',
          defaultValue: 'Нажмите, чтобы изменить имя'),
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
