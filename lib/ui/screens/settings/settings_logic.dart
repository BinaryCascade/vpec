import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/hive_helper.dart';
import '../../../utils/rounded_modal_sheet.dart';
import '../../../utils/snackbars.dart';
import '../../../utils/theme_helper.dart';
import 'settings_ui.dart';

enum UserMode {
  admin,
  student,
  employee,
  teacher,
  enrollee,
}

class SettingsLogic extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isEditMode = HiveHelper.getValue('isEditMode') ?? false;
  late StreamSubscription<User?> authListener;

  static bool get checkIsInEditMode {
    return SettingsLogic().getAccountEmail()!.isNotEmpty &&
        (HiveHelper.getValue('isEditMode') ?? false);
  }

  void startListenAuth() {
    authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user?.email == null) {
        isLoggedIn = false;
        notifyListeners();
      } else {
        isLoggedIn = true;
        notifyListeners();
      }
    });
  }

  Future<void> cancelListener() async {
    await authListener.cancel();
  }

  // show roundedModalSheet() for account login
  void accountLogin(BuildContext context) {
    roundedModalSheet(
      context: context,
      title: 'Войти в аккаунт',
      child: AccountLoginUI(),
    );
  }

  // login to firebase account with email and password
  void makeLogin(BuildContext context,
      {required String email, required password}) async {
    try {
      // trying to login
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      showSnackbar(context, text: 'Вход в аккаунт выполнен успешно');
    } on FirebaseAuthException {
      Navigator.pop(context);
      showSnackbar(context, text: 'Данные введены неверно');
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

  String? getAccountEmail() {
    if (FirebaseAuth.instance.currentUser!.email != null) {
      return FirebaseAuth.instance.currentUser!.email;
    } else {
      return '';
    }
  }

  static UserMode getAccountMode() {
    FirebaseAuth auth = FirebaseAuth.instance;

    switch (auth.currentUser!.email) {
      case 'admin@energocollege.ru':
        return UserMode.admin;
      case 'employee@energocollege.ru':
        return UserMode.employee;
      case 'teacher@energocollege.ru':
        return UserMode.teacher;
      default:
        if (HiveHelper().getValue('isEnrollee') == true) {
          return UserMode.enrollee;
        } else {
          return UserMode.student;
        }
    }
  }

  Future<void> chooseTheme(
      {required BuildContext context, required bool isAppThemeSetting}) async {
    String hiveKey = isAppThemeSetting ? 'theme' : 'pdfTheme';

    await roundedModalSheet(
      context: context,
      title: 'Выберите тему',
      child: Consumer<ThemeNotifier>(
        builder: (BuildContext context, value, Widget? child) {
          return ThemeChooserUI(
            hiveKey: hiveKey,
            lightThemeSelected: () {
              HiveHelper.saveValue(key: hiveKey, value: 'Светлая тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            darkThemeSelected: () {
              HiveHelper.saveValue(key: hiveKey, value: 'Тёмная тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            defaultThemeSelected: () {
              HiveHelper.removeValue(hiveKey);
              if (isAppThemeSetting) value.changeTheme(ThemeMode.system);
              Navigator.pop(context);
            },
            alwaysLightThemeDocumentChanged: (value) {
              HiveHelper
                  .saveValue(key: 'alwaysLightThemeDocument', value: value);
            },
          );
        },
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              ThemeHelper.isDarkMode() ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              ThemeHelper.isDarkMode() ? Brightness.light : Brightness.dark),
    );
  }

  void chooseLaunchOnStart(BuildContext context) {
    roundedModalSheet(
        context: context,
        title: 'Открывать при запуске',
        child: LaunchOnStartChooserUI());
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    HiveHelper.saveValue(key: 'isEditMode', value: isEditMode);
    notifyListeners();
  }
}
