import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';

Widget buildAccountBlock(BuildContext context) {
  return Column(
    children: [
      ListTile(
        onTap: () {
          SettingsLogic().accountLogin(context);
        },
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
          style: Theme.of(context).textTheme.headline3,
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
              style: Theme.of(context).textTheme.headline3,
            );
          },
        ),
      ),
    ],
  );
}
