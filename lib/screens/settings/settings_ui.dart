import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/debug/debug_screen.dart';
import '/utils/hive_helper.dart';
import '/utils/icons.dart';
import '/widgets/styled_widgets.dart';
import '../../theme.dart';
import '../../utils/firebase_auth.dart';
import 'settings_logic.dart';

class AccountBlock extends StatefulWidget {
  const AccountBlock({Key? key}) : super(key: key);

  @override
  State<AccountBlock> createState() => _AccountBlockState();
}

class _AccountBlockState extends State<AccountBlock> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAppAuth>(
      builder: (BuildContext context, auth, Widget? child) {
        return AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 400),
          child: Column(
            children: [
              StyledListTile(
                onTap: () => SettingsLogic.accountLogin(context),
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: context.palette.accentColor,
                  size: 32,
                ),
                title: 'Аккаунт',
                subtitle: auth.accountInfo.isLoggedIn
                    ? SettingsLogic.getAccountModeText(context)
                    : 'Нажмите, чтобы войти в аккаунт',
              ),
              StyledListTile(
                icon: Icon(
                  Icons.subject_outlined,
                  color: context.palette.accentColor,
                  size: 32,
                ),
                title: 'Выбрать группу',
                subtitle: 'Для показа расписания',
                onTap: () => SettingsLogic.chooseGroup(context),
              ),
              if (auth.accountInfo.level == AccountType.admin)
                Column(
                  children: [
                    HivedListTile(
                      onTap: () => SettingsLogic.changeName(context),
                      icon: Icon(
                        Icons.edit_outlined,
                        color: context.palette.accentColor,
                        size: 32.0,
                      ),
                      title: 'Имя для объявлений',
                      subtitleKey: 'username',
                      defaultValue: 'Текущее: нет (нажмите, чтобы изменить)',
                    ),
                    StyledListTile(
                      icon: Icon(
                        Icons.tune_outlined,
                        color: context.palette.accentColor,
                        size: 32.0,
                      ),
                      title: 'Режим редактирования',
                      subtitle:
                          context.watch<AccountEditorMode>().isEditorModeActive
                              ? 'Нажмите, чтобы выйти из режима редактирования'
                              : 'Нажмите, чтобы войти в режим редактирования',
                      onTap: () =>
                          context.read<AccountEditorMode>().toggleEditorMode(),
                    ),
                    StyledListTile(
                      icon: Icon(
                        Icons.construction_outlined,
                        color: context.palette.accentColor,
                        size: 32.0,
                      ),
                      title: 'Экран тестирования',
                      subtitle: 'Для дебага функций',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              const DebugScreen(),
                        ),
                      ),
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
        color: context.palette.accentColor,
      ),
      onTap: () async {
        await SettingsLogic.chooseTheme(context: context);
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
        color: context.palette.accentColor,
        size: 32.0,
      ),
    );
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
              TextFormField(
                controller: emailController,
                autofillHints: const <String>[AutofillHints.username],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.headline3,
                decoration: const InputDecoration(labelText: 'Введите email'),
              ),
              const SizedBox(height: 10),
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
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: const Text('Войти'),
                onPressed: () {
                  SettingsLogic().makeLogin(
                    context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AccountLogoutUI extends StatelessWidget {
  const AccountLogoutUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                child: const Text('Выйти'),
                onPressed: () => SettingsLogic.accountLogout(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EditNameUI extends StatelessWidget {
  EditNameUI({
    Key? key,
  }) : super(key: key);

  final TextEditingController nameController = TextEditingController();

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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                child: const Text('Сохранить'),
                onPressed: () {
                  HiveHelper.saveValue(
                    key: 'username',
                    value: nameController.value.text.trim(),
                  );
                  Navigator.pop(context);
                },
              ),
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

  const ThemeChooserUI({
    Key? key,
    required this.lightThemeSelected,
    required this.darkThemeSelected,
    required this.defaultThemeSelected,
    required this.hiveKey,
    required this.alwaysLightThemeDocumentChanged,
  }) : super(key: key);

  @override
  State<ThemeChooserUI> createState() => _ThemeChooserUIState();
}

class _ThemeChooserUIState extends State<ThemeChooserUI> {
  int selectedItem = 0;
  bool documentLightThemeSwitchState = false;

  @override
  void initState() {
    selectedItem = HiveHelper.getValue(widget.hiveKey) == null
        ? 2
        : HiveHelper.getValue(widget.hiveKey) == 'Светлая тема'
            ? 0
            : 1;
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
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Column(
        children: [
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.brightness_5_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Светлая тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 0,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              widget.lightThemeSelected();
              setState(() {
                selectedItem = value;
              });
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.brightness_2_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Тёмная тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 1,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              setState(() {
                widget.darkThemeSelected();
                setState(() {
                  selectedItem = value;
                });
              });
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.phonelink_setup_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Системная тема',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 2,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (dynamic value) {
              widget.defaultThemeSelected();
              setState(() {
                selectedItem = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            value: documentLightThemeSwitchState,
            activeColor: context.palette.accentColor,
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.description_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Всегда светлая тема для документов',
              style: Theme.of(context).textTheme.headline4,
            ),
            onChanged: (value) {
              widget.alwaysLightThemeDocumentChanged(value);
              setState(() {
                documentLightThemeSwitchState = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class LaunchOnStartChooserUI extends StatefulWidget {
  const LaunchOnStartChooserUI({Key? key}) : super(key: key);

  @override
  State<LaunchOnStartChooserUI> createState() => _LaunchOnStartChooserUIState();
}

class _LaunchOnStartChooserUIState extends State<LaunchOnStartChooserUI> {
  int selectedItem = HiveHelper.getValue('launchOnStart') ?? 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Column(
        children: [
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                VpecIconPack.news_outline,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'События',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 0,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (int? value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                  key: 'launchOnStartString',
                  value: 'События',
                );
                selectedItem = value!;
              });
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.notifications_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Объявления',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 1,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (int? value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                  key: 'launchOnStartString',
                  value: 'Объявления',
                );
                selectedItem = value!;
              });
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.access_time_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Расписание занятий',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 2,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (int? value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                  key: 'launchOnStartString',
                  value: 'Расписание занятий',
                );
                selectedItem = value!;
              });
            },
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            secondary: Center(
              widthFactor: 1,
              child: Icon(
                Icons.layers_outlined,
                color: context.palette.accentColor,
              ),
            ),
            title: Text(
              'Карта кабинетов',
              style: Theme.of(context).textTheme.headline4,
            ),
            value: 3,
            activeColor: context.palette.accentColor,
            groupValue: selectedItem,
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (int? value) {
              setState(() {
                HiveHelper.saveValue(key: 'launchOnStart', value: value);
                HiveHelper.saveValue(
                  key: 'launchOnStartString',
                  value: 'Карта кабинетов',
                );
                selectedItem = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ChooseGroupUI extends StatelessWidget {
  const ChooseGroupUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupsData>(builder: (context, logic, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButtonFormField<String>(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            value: GroupsData.getGroupsNames.first,
            isExpanded: true,
            isDense: false,
            items: GroupsData.getGroupsNames
                .map<DropdownMenuItem<String>>(
                  (group) => DropdownMenuItem<String>(
                    value: group,
                    child: Text(group),
                  ),
                )
                .toList(),
            onChanged: (value) => logic.onValueChanged(
              value,
              type: ChangedType.groupName,
            ),
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Специальность'),
            menuMaxHeight: 400,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: GroupsData.getCoursesNumbers.first,
                  items: GroupsData.getCoursesNumbers
                      .map<DropdownMenuItem<String>>(
                        (course) => DropdownMenuItem<String>(
                          value: course,
                          child: Text(course),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => logic.onValueChanged(
                    value,
                    type: ChangedType.groupCourse,
                  ),
                  style: Theme.of(context).textTheme.headline3,
                  decoration: const InputDecoration(labelText: 'Курс'),
                  menuMaxHeight: 400,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: GroupsData.getGroupNumbers.first,
                  items: GroupsData.getGroupNumbers
                      .map<DropdownMenuItem<String>>(
                        (groupNum) => DropdownMenuItem<String>(
                          value: groupNum,
                          child: Text(groupNum),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => logic.onValueChanged(
                    value,
                    type: ChangedType.groupNumber,
                  ),
                  style: Theme.of(context).textTheme.headline3,
                  decoration: const InputDecoration(labelText: 'Группа'),
                  menuMaxHeight: 400,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              activeColor: context.palette.accentColor,
              value: logic.isAccelerated,
              title: Text(
                'Ускоренная форма обучения',
                style: Theme.of(context).textTheme.headline3,
              ),
              onChanged: (value) => logic.onValueChanged(
                value,
                type: ChangedType.accelerated,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Будет выбрана группа:',
            style: Theme.of(context).textTheme.headline3,
          ),
          Builder(builder: (context) {
            return Text(
              logic.formedGroup,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            );
          }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Закрыть'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: logic.isSaveButtonEnabled
                      ? () => logic.saveFormedGroup(context)
                      : null,
                  child: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
