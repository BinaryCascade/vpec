import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vpec/utils/rounded_modal_sheet.dart';

class SettingsLogic extends NotificationListener {
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
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style,
                child: Text('Сохранить',
                    style: Theme.of(context).textTheme.bodyText1),
                onPressed: () {
                  saveNewName(nameController.value.text);
                  Navigator.pop(context);
                },
              )
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

  void saveNewName(String newName) {
    Box settings = Hive.box('settings');
    settings.put('username', newName);
  }
}
