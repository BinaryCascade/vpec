import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Widget hivedListTile(
    {@required BuildContext context,
    String title,
    @required String subtitleKey,
    @required String defaultValue,
    GestureTapCallback onTap,
    Icon icon}) {
  return ListTile(
    leading: Container(
        //  cringe fix to center icon. If you want to use Center()
        //  instead Container - you will get bamboozled
        height: double.infinity,
        child: icon),
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

Widget styledListTile(
    {@required BuildContext context,
    String title,
    String subtitle,
    Widget icon,
    GestureTapCallback onTap}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: ListTile(
      leading: Container(height: double.infinity, child: icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onTap: onTap,
    ),
  );
}
