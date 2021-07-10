import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// create ListTile where subtitle value getting from Hive.
///
/// [subtitleKey] - Hive key to get value
///
/// [defaultValue] - If key have no value, show this text
class HivedListTile extends StatelessWidget {
  final String title, subtitleKey, defaultValue;
  final GestureTapCallback? onTap;
  final Icon? icon;

  const HivedListTile(
      {Key? key,
      required this.title,
      required this.subtitleKey,
      required this.defaultValue,
      this.onTap,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      leading: SizedBox(
          //  cringe fix to center icon. If you want to use Center()
          //  instead SizedBox - you will get bamboozled
          height: double.infinity,
          child: icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      subtitle: ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(keys: [subtitleKey]),
        builder: (context, Box box, child) {
          return Text(
            box.get(subtitleKey, defaultValue: defaultValue),
            style: Theme.of(context).textTheme.subtitle1,
          );
        },
      ),
      onTap: onTap,
    );
  }
}

/// Just create normal ListTile with styled text
class StyledListTile extends StatelessWidget {
  final Widget? trailing, icon;
  final String title, subtitle;
  final GestureTapCallback? onTap;

  const StyledListTile(
      {Key? key,
      this.trailing,
      this.icon,
      required this.title,
      required this.subtitle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      trailing: trailing,
      leading:
          icon == null ? null : SizedBox(height: double.infinity, child: icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      onTap: onTap,
    );
  }
}
