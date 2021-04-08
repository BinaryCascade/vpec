import 'package:flutter/material.dart';
import '../../../ui/widgets/styled_widgets.dart';
import '../../../utils/icons.dart';
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
        title: 'Аккаунт сотрудника',
        subtitle: SettingsLogic().getAccountEmail().isEmpty
            ? 'Нажмите, чтобы войти в аккаунт'
            : SettingsLogic().getAccountEmail(),
      ),
      if (SettingsLogic().getAccountEmail().isNotEmpty)
        hivedListTile(
            context: context,
            onTap: () => SettingsLogic().changeName(context),
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).accentColor,
              size: 32,
            ),
            title: 'Имя для объявлений',
            subtitleKey: 'username',
            defaultValue: 'Текущее: нет (нажмите, чтобы изменить)'),
    ],
  );
}

Widget buildThemeChooser(BuildContext context) {
  return Column(
    children: [
      hivedListTile(
        context: context,
        title: 'Тема приложения',
        subtitleKey: 'theme',
        defaultValue: 'Системная тема',
        icon: Icon(
          Icons.brightness_6_outlined,
          size: 32,
          color: Theme.of(context).accentColor,
        ),
        onTap: () async {
          await SettingsLogic().chooseTheme(context: context, isAppThemeSetting: true);
          // ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
        },
      ),
      hivedListTile(
        context: context,
        title: 'Тема документов',
        subtitleKey: 'pdfTheme',
        defaultValue: 'Системная тема',
        icon: Icon(
          Icons.tonality_outlined,
          size: 32,
          color: Theme.of(context).accentColor,
        ),
        onTap: () {
          SettingsLogic().chooseTheme(context: context, isAppThemeSetting: false);
        },
      ),
    ],
  );
}

Widget buildLaunchOnStartChooser(BuildContext context) {
  return hivedListTile(
      onTap: () => SettingsLogic().chooseLaunchOnStart(context),
      context: context,
      subtitleKey: 'launchOnStartString',
      defaultValue: 'Новости',
      title: 'Открывать при запуске',
      icon: Icon(
        Icons.launch_outlined,
        color: Theme.of(context).accentColor,
        size: 32,
      ));
}

Widget buildBackgroundTaskWidgets(BuildContext context) {
  return Column(
    children: [
      hivedListTile(
          context: context,
          title: 'Проверять расписание в фоне',
          icon: Icon(
            Icons.history_outlined,
            color: Theme.of(context).accentColor,
            size: 32.0,
          ),
          onTap: () => SettingsLogic().changeBackgroundCheck(context),
          subtitleKey: 'backgroundCheck',
          defaultValue: 'Выключено'),
      styledListTile(
        context: context,
        icon: Icon(
          VpecIconPack.battery_saver_line,
          color: Theme.of(context).accentColor,
          size: 32.0,
        ),
        title: 'Отключить оптимизацию батареи',
        subtitle: 'Улучшить качество фоновой проверки',
        onTap: () => SettingsLogic().checkForBackgroundRestrict,
      ),
    ],
  );
}
