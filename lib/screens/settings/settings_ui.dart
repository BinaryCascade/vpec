import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/debug/debug_screen.dart';
import '/ui/widgets/styled_widgets.dart';
import '/utils/hive_helper.dart';
import '/utils/icons.dart';
import 'settings_logic.dart';

class AccountBlock extends StatefulWidget {
  const AccountBlock({Key? key}) : super(key: key);

  @override
  _AccountBlockState createState() => _AccountBlockState();
}

class _AccountBlockState extends State<AccountBlock> {
  @override
  void initState() {
    context.read<SettingsLogic>().startListenAuth();
    super.initState();
  }

  @override
  void deactivate() {
    context.read<SettingsLogic>().cancelListener();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsLogic>(
      builder: (BuildContext context, storage, Widget? child) {
        return AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              StyledListTile(
                  onTap: () => SettingsLogic.accountLogin(context),
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 32,
                  ),
                  title: 'Аккаунт',
                  subtitle: storage.isLoggedIn
                      ? SettingsLogic.getAccountModeText()
                      : 'Нажмите, чтобы войти в аккаунт'),
              if (SettingsLogic.getAccountMode() == UserMode.admin)
                Column(
                  children: [
                    HivedListTile(
                        onTap: () => SettingsLogic.changeName(context),
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 32.0,
                        ),
                        title: 'Имя для объявлений',
                        subtitleKey: 'username',
                        defaultValue: 'Текущее: нет (нажмите, чтобы изменить)'),
                    StyledListTile(
                      icon: Icon(
                        Icons.tune_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 32.0,
                      ),
                      title: 'Режим редактирования',
                      subtitle: storage.isEditMode
                          ? 'Нажмите, чтобы выйти из режима редактирования'
                          : 'Нажмите, чтобы войти в режим редактирования',
                      onTap: () => storage.toggleEditMode(),
                    ),
                    StyledListTile(
                      icon: Icon(
                        Icons.construction_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 32.0,
                      ),
                      title: 'Экран тестирования',
                      subtitle: 'Для дебага функций',
                      onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                const DebugScreen(),
                          )),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class AppThemeListTile extends StatelessWidget {
  const AppThemeListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HivedListTile(
      title: 'Тема приложения',
      subtitleKey: 'theme',
      defaultValue: 'Системная тема',
      icon: Icon(
        Icons.brightness_6_outlined,
        size: 32.0,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onTap: () async {
        await SettingsLogic()
            .chooseTheme(context: context, isAppThemeSetting: true);
        // ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
      },
    );
  }
}

class LaunchOnStartChooser extends StatelessWidget {
  const LaunchOnStartChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HivedListTile(
        onTap: () => SettingsLogic().chooseLaunchOnStart(context),
        subtitleKey: 'launchOnStartString',
        defaultValue: 'События',
        title: 'Открывать при запуске',
        icon: Icon(
          Icons.launch_outlined,
          color: Theme.of(context).colorScheme.secondary,
          size: 32.0,
        ));
  }
}

class AccountLoginUI extends StatelessWidget {
  const AccountLoginUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Column(
      children: [
        AutofillGroup(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  controller: emailController,
                  autofillHints: const <String>[AutofillHints.username],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.headline3,
                  decoration: const InputDecoration(labelText: 'Введите email'),
                )),
            TextFormField(
              controller: passwordController,
              autofillHints: const <String>[AutofillHints.password],
              textInputAction: TextInputAction.done,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              style: Theme.of(context).textTheme.headline3,
              decoration: const InputDecoration(labelText: 'Введите пароль'),
            ),
          ],
        )),
        ButtonBar(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              child: const Text('Войти'),
              onPressed: () {
                SettingsLogic().makeLogin(context,
                    email: emailController.text,
                    password: passwordController.text);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class EditNameUI extends StatelessWidget {
  const EditNameUI({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Введите имя'),
        ),
        ButtonBar(
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              child: const Text('Сохранить'),
              onPressed: () {
                HiveHelper.saveValue(
                    key: 'username', value: nameController.value.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ThemeChooserUI extends StatefulWidget {
  final Function lightThemeSelected;
  final Function darkThemeSelected;
  final Function defaultThemeSelected;
  final String hiveKey;
  final void Function(bool) alwaysLightThemeDocumentChanged;

  const ThemeChooserUI(
      {Key? key,
      required this.lightThemeSelected,
      required this.darkThemeSelected,
      required this.defaultThemeSelected,
      required this.hiveKey,
      required this.alwaysLightThemeDocumentChanged})
      : super(key: key);

  @override
  _ThemeChooserUIState createState() => _ThemeChooserUIState();
}

class _ThemeChooserUIState extends State<ThemeChooserUI> {
  int? selectedItem = 0;
  bool documentLightThemeSwitchState = false;

  @override
  void initState() {
    if (HiveHelper.getValue(widget.hiveKey) == null) {
      selectedItem = 2;
    } else {
      selectedItem =
          HiveHelper.getValue(widget.hiveKey) == 'Светлая тема' ? 0 : 1;
    }
    if (HiveHelper.getValue('alwaysLightThemeDocument') == null) {
      HiveHelper.saveValue(key: 'alwaysLightThemeDocument', value: false);
    }
    if (HiveHelper.getValue('alwaysLightThemeDocument')) {
      documentLightThemeSwitchState = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(Icons.brightness_5_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'Светлая тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 0,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              widget.lightThemeSelected();
              setState(() {
                selectedItem = value;
              });
            }),
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(Icons.brightness_2_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'Тёмная тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 1,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                widget.darkThemeSelected();
                setState(() {
                  selectedItem = value;
                });
              });
            }),
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(Icons.phonelink_setup_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'Системная тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 2,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              widget.defaultThemeSelected();
              setState(() {
                selectedItem = value;
              });
            }),
        const Divider(),
        SwitchListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            value: documentLightThemeSwitchState,
            activeColor: Theme.of(context).colorScheme.secondary,
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.description_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            title: Text('Всегда светлая тема для документов',
                style: Theme.of(context).textTheme.headline4),
            onChanged: (value) {
              widget.alwaysLightThemeDocumentChanged(value);
              setState(() {
                documentLightThemeSwitchState = value;
              });
            }),
        const SizedBox(height: 7),
      ],
    );
  }
}

class LaunchOnStartChooserUI extends StatefulWidget {
  const LaunchOnStartChooserUI({Key? key}) : super(key: key);

  @override
  _LaunchOnStartChooserUIState createState() => _LaunchOnStartChooserUIState();
}

class _LaunchOnStartChooserUIState extends State<LaunchOnStartChooserUI> {
  int? selectedItem = 0;

  @override
  void initState() {
    if (HiveHelper.getValue('launchOnStart') != null) {
      selectedItem = HiveHelper.getValue('launchOnStart');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(VpecIconPack.news_outline,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'События',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 0,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                    key: 'launchOnStartString', value: 'События');
                selectedItem = value;
              });
            }),
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(Icons.notifications_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'Объявления',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 1,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                    key: 'launchOnStartString', value: 'Объявления');
                selectedItem = value;
              });
            }),
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(Icons.access_time_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'Звонки',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 2,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                    key: 'launchOnStartString', value: 'Звонки');
                selectedItem = value;
              });
            }),
        RadioListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(Icons.dashboard_outlined,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(
              'Расписание занятий',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 3,
            activeColor: Theme.of(context).colorScheme.secondary,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                    key: 'launchOnStartString', value: 'Расписание занятий');
                selectedItem = value;
              });
            }),
      ],
    );
  }
}
