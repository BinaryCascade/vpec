import 'package:battery_optimization/battery_optimization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpec/utils/hive_helper.dart';
import 'package:vpec/utils/icons.dart';
import 'package:vpec/utils/rounded_modal_sheet.dart';
import 'package:vpec/utils/theme_helper.dart';
import 'package:workmanager/workmanager.dart';

class SettingsLogic {
  // show roundedModalSheet() for account login

  void accountLogin(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    roundedModalSheet(
      context: context,
      title: 'Войти в аккаунт',
      child: Column(
        children: [
          AutofillGroup(
              child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor)),
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
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ),
                    OutlinedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      child: Text(
                        'Войти',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                      onPressed: () async {
                        try {
                          // trying to login
                          await FirebaseAuth.instance.signOut();
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Вход в аккаунт выполнен успешно"),
                          ));
                        } on FirebaseAuthException {
                          // something went wrong, make anonymously login
                          await FirebaseAuth.instance.signInAnonymously();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Данные введены неверно"),
                          ));
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // show roundedModalSheet() for editing user's name
  // (name used for announcements post)
  void changeName(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    roundedModalSheet(
      title: 'Изменить имя',
      context: context,
      child: Column(
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
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
              OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style,
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
                onPressed: () {
                  HiveHelper().saveValue(
                      key: 'username', value: nameController.value.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getAccountEmail() {
    if (FirebaseAuth.instance.currentUser.email != null) {
      return FirebaseAuth.instance.currentUser.email;
    } else {
      return '';
    }
  }

  Future<bool> chooseTheme(
      {BuildContext context, bool isAppThemeSetting}) async {
    String hiveKey = isAppThemeSetting ? 'theme' : 'pdfTheme';
    int selectedItem = 0;
    if (HiveHelper().getValue(hiveKey) == null) {
      selectedItem = 2;
    } else {
      selectedItem = HiveHelper().getValue(hiveKey) == 'Светлая тема' ? 0 : 1;
    }

    await roundedModalSheet(
        context: context,
        title: 'Выберите тему',
        child: StatefulBuilder(builder: (context, setModalState) {
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
                  onChanged: (value) {
                    setModalState(() {
                      HiveHelper()
                          .saveValue(key: hiveKey, value: 'Светлая тема');

                      selectedItem = value;
                      if (isAppThemeSetting) {
                        Get.changeThemeMode(ThemeMode.light);
                      }

                      Navigator.pop(context);
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
                  onChanged: (value) {
                    setModalState(() {
                      HiveHelper()
                          .saveValue(key: hiveKey, value: 'Тёмная тема');
                      selectedItem = value;

                      if (isAppThemeSetting) {
                        Get.changeThemeMode(ThemeMode.dark);
                      }
                      Navigator.pop(context);
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
                  onChanged: (value) {
                    setModalState(() {
                      Get.changeThemeMode(ThemeMode.system);
                      selectedItem = value;
                      HiveHelper().removeValue(hiveKey);
                      Navigator.pop(context);
                    });
                  }),
            ],
          );
        }));
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    return true;
  }

  void chooseLaunchOnStart(BuildContext context) {
    int selectedItem = 0;
    if (HiveHelper().getValue('launchOnStart') != null) {
      selectedItem = HiveHelper().getValue('launchOnStart');
    } //Show previously selected item on modal open
    roundedModalSheet(
        context: context,
        title: 'Открывать при запуске',
        child: StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) setModalState) {
            return Column(
              children: [
                RadioListTile(
                    secondary: Icon(VEKiconPack.news,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      'Новости',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    value: 0,
                    activeColor: Theme.of(context).accentColor,
                    groupValue: selectedItem,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      setModalState(() {
                        HiveHelper()
                            .saveValue(key: 'launchOnStart', value: value);
                        HiveHelper().saveValue(
                            key: 'launchOnStartString', value: 'Новости');
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
                    onChanged: (value) {
                      setModalState(() {
                        HiveHelper()
                            .saveValue(key: 'launchOnStart', value: value);
                        HiveHelper().saveValue(
                            key: 'launchOnStartString', value: 'Объявления');
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
                    onChanged: (value) {
                      setModalState(() {
                        HiveHelper()
                            .saveValue(key: 'launchOnStart', value: value);
                        HiveHelper().saveValue(
                            key: 'launchOnStartString', value: 'Звонки');
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
                    onChanged: (value) {
                      setModalState(() {
                        HiveHelper()
                            .saveValue(key: 'launchOnStart', value: value);
                        HiveHelper().saveValue(
                            key: 'launchOnStartString',
                            value: 'Расписание занятий');
                        selectedItem = value;
                      });
                    }),
              ],
            );
          },
        ));
  }

  void changeBackgroundCheck(BuildContext context) {
    int selectedIndex = 0;
    if (HiveHelper().getValue('backgroundCheckIndex') != null) {
      selectedIndex = HiveHelper().getValue('backgroundCheckIndex');
    }

    roundedModalSheet(
        context: context,
        title: 'Выберите значение',
        child: StatefulBuilder(builder: (BuildContext context,
            void Function(void Function()) setModalState) {
          return Column(
            children: [
              RadioListTile(
                  secondary: Icon(Icons.sync_disabled_outlined,
                      color: Theme.of(context).accentColor),
                  title: Text(
                    'Выключить проверку',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  value: 0,
                  activeColor: Theme.of(context).accentColor,
                  groupValue: selectedIndex,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    setModalState(() {
                      HiveHelper()
                          .saveValue(key: 'backgroundCheckIndex', value: value);
                      HiveHelper().saveValue(
                          key: 'backgroundCheck', value: 'Выключено');
                      selectedIndex = value;
                      Workmanager.cancelAll();
                    });
                  }),
              RadioListTile(
                  secondary: Icon(Icons.sync_outlined,
                      color: Theme.of(context).accentColor),
                  title: Text(
                    'Включить проверку',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  value: 1,
                  activeColor: Theme.of(context).accentColor,
                  groupValue: selectedIndex,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    setModalState(() {
                      HiveHelper()
                          .saveValue(key: 'backgroundCheckIndex', value: value);
                      HiveHelper()
                          .saveValue(key: 'backgroundCheck', value: 'Включено');
                      selectedIndex = value;
                    });
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Внимание'),
                          content: Text(
                              'Фоновая проверка расписания будет активирована '
                              'при следующем запуске приложения. Также '
                              'обратите внимание, что для того, чтобы '
                              'проверка была быстрой, то лучше отключить '
                              'оптимизацию батареи для этого приложения. '
                              'Сделать это можно с помощью пункта ниже'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Закрыть',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
                                  ),
                                ))
                          ],
                        );
                      },
                    );
                  }),
            ],
          );
        }));
  }

  void checkForBackgroundRestrict(BuildContext context) {
    BatteryOptimization.isIgnoringBatteryOptimizations().then((onValue) {
      if (onValue) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Уже оптимизировано'),
        ));
      } else {
        BatteryOptimization.openBatteryOptimizationSettings();
      }
    });
  }
}
