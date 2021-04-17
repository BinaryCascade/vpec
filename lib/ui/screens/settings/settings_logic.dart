import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/hive_helper.dart';
import '../../../utils/rounded_modal_sheet.dart';
import '../../../utils/theme_helper.dart';
import 'settings_ui.dart';

class SettingsLogic {
  // show roundedModalSheet() for account login
  void accountLogin(BuildContext context) {
    roundedModalSheet(
      context: context,
      title: 'Войти в аккаунт',
      child: AccountLoginUI(),
    );
  }

  // login to firebase account with email and password
  void makeLogin(BuildContext context, {String email, password}) async {
    try {
      // trying to login
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
  }

  // show roundedModalSheet() for editing user's name
  // (name used for announcements post)
  void changeName(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    roundedModalSheet(
      title: 'Изменить имя',
      context: context,
      child: EditNameUI(nameController: nameController),
    );
  }

  String getAccountEmail() {
    if (FirebaseAuth.instance.currentUser.email != null) {
      return FirebaseAuth.instance.currentUser.email;
    } else {
      return '';
    }
  }

  Future<void> chooseTheme(
      {BuildContext context, bool isAppThemeSetting}) async {
    String hiveKey = isAppThemeSetting ? 'theme' : 'pdfTheme';

    await roundedModalSheet(
      context: context,
      title: 'Выберите тему',
      child: Consumer<ThemeNotifier>(
        builder: (BuildContext context, value, Widget child) {
          return ThemeChooserUI(
            hiveKey: hiveKey,
            lightThemeSelected: () {
              HiveHelper().saveValue(key: hiveKey, value: 'Светлая тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            darkThemeSelected: () {
              HiveHelper().saveValue(key: hiveKey, value: 'Тёмная тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            defaultThemeSelected: () {
              HiveHelper().removeValue(hiveKey);
              if (isAppThemeSetting) value.changeTheme(ThemeMode.system);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              ThemeHelper().isDarkMode() ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              ThemeHelper().isDarkMode() ? Brightness.light : Brightness.dark),
    );
  }

  void chooseLaunchOnStart(BuildContext context) {
    roundedModalSheet(
        context: context,
        title: 'Открывать при запуске',
        child: LaunchOnStartChooserUI());
  }
}
