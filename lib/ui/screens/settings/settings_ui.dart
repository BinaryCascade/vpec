import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/widgets/styled_widgets.dart';
import '../../../utils/hive_helper.dart';
import '../../../utils/icons.dart';
import 'settings_logic.dart';

// Two ListTiles for account management
class AccountBlock extends StatefulWidget {
  @override
  _AccountBlockState createState() => _AccountBlockState();
}

class _AccountBlockState extends State<AccountBlock>
    with TickerProviderStateMixin {
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
          vsync: this,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 400),
          child: Column(
            children: [
              StyledListTile(
                  onTap: () => storage.accountLogin(context),
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Theme.of(context).accentColor,
                    size: 32,
                  ),
                  title: 'Аккаунт сотрудника',
                  subtitle: storage.isLoggedIn
                      ? storage.getAccountEmail()!
                      : 'Нажмите, чтобы войти в аккаунт'),
              if (storage.isLoggedIn)
                Column(
                  children: [
                    HivedListTile(
                        onTap: () => storage.changeName(context),
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Theme.of(context).accentColor,
                          size: 32.0,
                        ),
                        title: 'Имя для объявлений',
                        subtitleKey: 'username',
                        defaultValue: 'Текущее: нет (нажмите, чтобы изменить)'),
                    StyledListTile(
                      icon: Icon(
                        Icons.tune_outlined,
                        color: Theme.of(context).accentColor,
                        size: 32.0,
                      ),
                      title: 'Режим редактирования',
                      subtitle: storage.isEditMode
                          ? 'Нажмите, чтобы выйти из режима редактирования'
                          : 'Нажмите, чтобы войти в режим редактирования',
                      onTap: () => storage.toggleEditMode(),
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
  @override
  Widget build(BuildContext context) {
    return HivedListTile(
      title: 'Тема приложения',
      subtitleKey: 'theme',
      defaultValue: 'Системная тема',
      icon: Icon(
        Icons.brightness_6_outlined,
        size: 32.0,
        color: Theme.of(context).accentColor,
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
  @override
  Widget build(BuildContext context) {
    return HivedListTile(
        onTap: () => SettingsLogic().chooseLaunchOnStart(context),
        subtitleKey: 'launchOnStartString',
        defaultValue: 'События',
        title: 'Открывать при запуске',
        icon: Icon(
          Icons.launch_outlined,
          color: Theme.of(context).accentColor,
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
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: emailController,
                  autofillHints: [AutofillHints.username],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.headline3,
                  decoration: InputDecoration(
                      labelText: 'Введите email',
                      labelStyle: Theme.of(context).textTheme.headline3,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor))),
                )),
            TextFormField(
              controller: passwordController,
              autofillHints: [AutofillHints.password],
              textInputAction: TextInputAction.done,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                  labelText: 'Введите пароль',
                  labelStyle: Theme.of(context).textTheme.headline3,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor))),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ButtonBar(
            buttonPadding: EdgeInsets.zero,
            children: [
              Wrap(
                spacing: 12,
                children: [
                  TextButton(
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                  OutlinedButton(
                    style: Theme.of(context).outlinedButtonTheme.style,
                    child: Text(
                      'Войти',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                    onPressed: () {
                      SettingsLogic().makeLogin(context,
                          email: emailController.text,
                          password: passwordController.text);
                    },
                  )
                ],
              ),
            ],
          ),
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
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                  labelText: 'Введите имя',
                  labelStyle: Theme.of(context).textTheme.headline3,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor))),
            )),
        ButtonBar(
          children: <Widget>[
            TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Отмена',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
            OutlinedButton(
              style: Theme.of(context).outlinedButtonTheme.style,
              child: Text(
                'Сохранить',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
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
    if (HiveHelper.getValue('alwaysLightThemeDocument') == null)
      HiveHelper.saveValue(key: 'alwaysLightThemeDocument', value: false);
    if (HiveHelper.getValue('alwaysLightThemeDocument'))
      documentLightThemeSwitchState = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
            secondary: Icon(Icons.brightness_5_outlined,
                color: Theme.of(context).accentColor),
            title: Text(
              'Светлая тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 0,
            activeColor: Theme.of(context).accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              widget.lightThemeSelected();
              setState(() {
                selectedItem = value;
              });
            }),
        RadioListTile(
            secondary: Icon(Icons.brightness_2_outlined,
                color: Theme.of(context).accentColor),
            title: Text(
              'Тёмная тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 1,
            activeColor: Theme.of(context).accentColor,
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
            secondary: Icon(Icons.phonelink_setup_outlined,
                color: Theme.of(context).accentColor),
            title: Text(
              'Системная тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 2,
            activeColor: Theme.of(context).accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              widget.defaultThemeSelected();
              setState(() {
                selectedItem = value;
              });
            }),
        Divider(),
        SwitchListTile(
            value: documentLightThemeSwitchState,
            activeColor: Theme.of(context).accentColor,
            secondary: Icon(
              Icons.description_outlined,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Всегда светлая тема для документов',
                style: Theme.of(context).textTheme.headline4),
            onChanged: (value) {
              widget.alwaysLightThemeDocumentChanged(value);
              setState(() {
                documentLightThemeSwitchState = value;
              });
            }),
        SizedBox(height: 7),
      ],
    );
  }
}

class LaunchOnStartChooserUI extends StatefulWidget {
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
            secondary: Icon(VpecIconPack.news_outline,
                color: Theme.of(context).accentColor),
            title: Text(
              'События',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 0,
            activeColor: Theme.of(context).accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper
                    .saveValue(key: 'launchOnStartString', value: 'События');
                selectedItem = value;
              });
            }),
        RadioListTile(
            secondary: Icon(Icons.notifications_outlined,
                color: Theme.of(context).accentColor),
            title: Text(
              'Объявления',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 1,
            activeColor: Theme.of(context).accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper
                    .saveValue(key: 'launchOnStartString', value: 'Объявления');
                selectedItem = value;
              });
            }),
        RadioListTile(
            secondary: Icon(Icons.access_time_outlined,
                color: Theme.of(context).accentColor),
            title: Text(
              'Звонки',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 2,
            activeColor: Theme.of(context).accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper
                    .saveValue(key: 'launchOnStartString', value: 'Звонки');
                selectedItem = value;
              });
            }),
        RadioListTile(
            secondary: Icon(Icons.dashboard_outlined,
                color: Theme.of(context).accentColor),
            title: Text(
              'Расписание занятий',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 3,
            activeColor: Theme.of(context).accentColor,
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
