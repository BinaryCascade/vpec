import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/firebase_auth.dart';
import '/utils/hive_helper.dart';
import '/utils/theme_helper.dart';
import '/utils/utils.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/snackbars.dart';
import 'settings_ui.dart';

class SettingsLogic extends ChangeNotifier {
  // show roundedModalSheet() for account login
  static Future<void> accountLogin(BuildContext context) async {
    if (context.read<FirebaseAppAuth>().accountInfo.level !=
        AccessLevel.entrant) {
      await showRoundedModalSheet(
        context: context,
        title: 'Выйти из аккаунта?',
        child: const AccountLogoutUI(),
      );
    } else {
      await showRoundedModalSheet(
        context: context,
        title: 'Войти в аккаунт',
        child: const AccountLoginUI(),
      );
    }
  }

  // login to firebase account with email and password
  void makeLogin(BuildContext context,
      {required String email, required password}) async {
    try {
      // trying to login
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
    } on FirebaseAuthException {
      Navigator.pop(context);
      showSnackBar(context, text: 'Данные введены неверно');
    }
    catch (e) {
      Navigator.pop(context);
      showSnackBar(context, text: e.toString());
    }
  }

  static Future<void> accountLogout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
    } catch (e) {
      showSnackBar(context, text: 'Ошибка выхода из аккаунта');
    }
  }

  // show roundedModalSheet() for editing user's name
  // (name used for announcements post)
  static void changeName(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    showRoundedModalSheet(
      title: 'Изменить имя',
      context: context,
      child: EditNameUI(nameController: nameController),
    );
  }

  static String getAccountModeText(BuildContext context) {
    switch (context.read<FirebaseAppAuth>().accountInfo.level) {
      case AccessLevel.admin:
        return 'Администратор';
      case AccessLevel.student:
        return 'Студент';
      case AccessLevel.employee:
        return 'Работник';
      case AccessLevel.teacher:
        return 'Преподаватель';
      case AccessLevel.entrant:
        return 'Абитуриент';
      default:
        return 'Неизвестно';
    }
  }

  Future<void> chooseTheme(
      {required BuildContext context, required bool isAppThemeSetting}) async {
    String hiveKey = isAppThemeSetting ? 'theme' : 'pdfTheme';

    await showRoundedModalSheet(
      context: context,
      title: 'Выберите тему',
      child: Consumer<ThemeNotifier>(
        builder: (BuildContext context, value, Widget? child) {
          return ThemeChooserUI(
            hiveKey: hiveKey,
            lightThemeSelected: () {
              HiveHelper.saveValue(key: hiveKey, value: 'Светлая тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.light);
            },
            darkThemeSelected: () {
              HiveHelper.saveValue(key: hiveKey, value: 'Тёмная тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.dark);
            },
            defaultThemeSelected: () {
              HiveHelper.removeValue(hiveKey);
              if (isAppThemeSetting) value.changeTheme(ThemeMode.system);
            },
            alwaysLightThemeDocumentChanged: (value) {
              HiveHelper.saveValue(
                  key: 'alwaysLightThemeDocument', value: value);
            },
          );
        },
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              ThemeHelper.isDarkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              ThemeHelper.isDarkMode ? Brightness.light : Brightness.dark),
    );
  }

  void chooseLaunchOnStart(BuildContext context) {
    showRoundedModalSheet(
        context: context,
        title: 'Открывать при запуске',
        child: const LaunchOnStartChooserUI());
  }
}
