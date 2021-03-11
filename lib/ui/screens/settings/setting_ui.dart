import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';

Widget buildAccountBlock(BuildContext context) {
  return ListTile(
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
    title: GestureDetector(
      onTap: () => SettingsLogic().changeName(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Text(
              'userName',
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, top: 2, bottom: 2),
              child: Icon(Icons.create_outlined,
                  color: Theme.of(context).accentColor, size: 16.0),
            ),
          ],
        ),
      ),
    ),
    subtitle: Text('Нажмите, чтобы войти в аккаунт'),
  );
}
