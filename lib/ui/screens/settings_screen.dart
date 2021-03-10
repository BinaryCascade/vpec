import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' as schedule;
import 'package:vpec/utils/rounded_modal_sheet.dart';

class SettingsScreen extends StatefulWidget {
  static final routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var brightness =
        schedule.SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: _accountLogin,
            leading: Container(
              height: double.infinity,
              child: Icon(
                Icons.account_circle_outlined,
                color: Theme.of(context).accentColor,
                size: 32,
              ),
            ),
            title: GestureDetector(
              onTap: () => print('_changeMyName'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: <Widget>[
                    Text(
                      'userName',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 2, bottom: 2),
                      child: Icon(Icons.create_outlined,
                          color: Theme.of(context).accentColor, size: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            subtitle: Text('Нажмите, чтобы войти в аккаунт'),
          ),
        ],
      ),
    );
  }

  void _accountLogin() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    roundedModalSheet(
      context: context,
      title: 'Войти в аккаунт',
      contentChild: Column(
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
}
