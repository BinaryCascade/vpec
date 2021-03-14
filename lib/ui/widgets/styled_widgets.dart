import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Widget styledListTile(
    {@required BuildContext context,
    String title,
    @required String subtitleKey,
    @required String defaultValue,
    GestureTapCallback onTap,
    Icon icon}) {
  return ListTile(
    leading: icon,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline3,
    ),
    subtitle: ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(keys: [subtitleKey]),
      builder: (context, box, child) {
        return Text(
          box.get(subtitleKey, defaultValue: defaultValue),
          style: Theme.of(context).textTheme.subtitle1,
        );
      },
    ),
    onTap: onTap,
  );
}
