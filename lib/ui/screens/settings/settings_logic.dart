import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:vpec/utils/rounded_modal_sheet.dart';

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
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: emailController,
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
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor))),
              )),
          TextFormField(
            controller: passwordController,
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
          ButtonBar(
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
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
                child: Text('Отмена',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),),
              ),
              OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style,
                child: Text('Сохранить',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),),
                onPressed: () {
                  saveValue(key: 'username', value: nameController.value.text);
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
      return 'Нажмите, чтобы войти в аккаунт';
    }
  }

  void saveValue({String key, dynamic value}) {
    Box settings = Hive.box('settings');
    settings.put(key, value);
  }

  void removeValue(String key) {
    Box settings = Hive.box('settings');
    settings.delete(key);
  }

  void chooseTheme(BuildContext context) {
    var settings = Hive.box('settings');
    int selectedItem = 0;
    if (settings.get('theme') == null) {
      selectedItem = 2;
    } else {
      selectedItem = settings.get('theme') == 'Светлая тема' ? 0 : 1;
    }

    roundedModalSheet(
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
                      SettingsLogic()
                          .saveValue(key: 'theme', value: 'Светлая тема');
                      Get.changeThemeMode(ThemeMode.light);
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
                  onChanged: (value) {
                    setModalState(() {
                      SettingsLogic()
                          .saveValue(key: 'theme', value: 'Тёмная тема');
                      Get.changeThemeMode(ThemeMode.dark);
                      selectedItem = value;
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
                      SettingsLogic().removeValue('theme');
                    });
                  }),
            ],
          );
        }));
  }
}
