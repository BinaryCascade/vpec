import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/utils/hive_helper.dart';
import '/utils/theme_helper.dart';
import '/utils/utils.dart';
import '../../utils/firebase_auth.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/snackbars.dart';
import '../schedule/schedule_screen.dart';
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
  void makeLogin(
    BuildContext context, {
    required String email,
    required password,
  }) async {
    try {
      // trying to login
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
    } on FirebaseAuthException {
      Navigator.pop(context);
      showSnackBar(context, text: 'Данные введены неверно');
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, text: e.toString());
    }
  }

  static Future<void> accountLogout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.homeScreen,
        (route) => false,
      );
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

  Future<void> chooseTheme({
    required BuildContext context,
    required bool isAppThemeSetting,
  }) async {
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
                key: 'alwaysLightThemeDocument',
                value: value,
              );
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
            ThemeHelper.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  void chooseLaunchOnStart(BuildContext context) {
    showRoundedModalSheet(
      context: context,
      title: 'Открывать при запуске',
      child: const LaunchOnStartChooserUI(),
    );
  }

  static Future<void> chooseGroup(BuildContext context) async {
    await showRoundedModalSheet(
      context: context,
      title: 'Выберите группу',
      child: ChangeNotifierProvider<GroupsData>(
        create: (_) => GroupsData(),
        child: const ChooseGroupUI(),
      ),
    );
  }
}

class GroupsData extends ChangeNotifier {
  /// Stores the formed group of [selectedGroup], [selectedCourse]
  /// and [selectedGroupNumber]
  String formedGroup = '00.00.00.00';

  /// Stores user picked group in [ChooseGroupUI]
  /// In the final case, it is converted to the group identification
  ///
  /// e.x: **09.02.01**-1-18
  String selectedGroup = getGroupsNames.first;

  /// Stores user picked course (1-4) in [ChooseGroupUI].
  /// In the final case, it is converted to the year of admission to study
  ///
  /// e.x: 09.02.01-1-**18**
  String selectedCourse = getCoursesNumbers.first;

  /// Stores user picked group number (1-2) in [ChooseGroupUI]
  ///
  /// e.x: 09.02.01-**1**-18
  String selectedGroupNumber = getGroupNumbers.first;

  /// Determines whether the form of study is accelerated or not.
  ///
  /// e.x: 13.02.09-1-21**у**
  bool isAccelerated = false;

  /// controls whether the save button is enabled or not.
  /// Updated by the [checkSaveButtonAvailable] method
  bool isSaveButtonEnabled = false;

  /// Stores groups names and their number identification in key-value type.
  ///
  /// Key is a group name
  ///
  /// Value is a group number identification
  static final Map<String, String> _groups = {
    'Выберите группу': '00.00.00.00',
    'Компьютерные системы и комплексы': '09.02.01',
    'Электрические станции, сети и системы': '13.02.03',
    'Релейная защита и автоматизация электроэнергетических систем': '13.02.06',
    'Электроснабжение (по отраслям)': '13.02.07',
    'Монтаж и эксплуатация линий электропередачи': '13.02.09',
    'Экономика и бухгалтерский учет (по отраслям)': '38.02.01',
    'Гостиничное дело': '43.02.14',
    'Банковское дело': '38.02.07',
    'Коммерция (по отраслям)': '38.02.04',
  };

  /// Returns a list of group names in [_groups] collection
  ///
  /// See more info: [selectedGroup]
  static List<String> get getGroupsNames {
    return _groups.keys.toList();
  }

  /// Returns a generated list of courses (1-4)
  ///
  /// See more info: [selectedCourse]
  static List<String> get getCoursesNumbers {
    return List.generate(4, (index) => (index + 1).toString());
  }

  /// Returns a generated list of group numbers (1-4)
  ///
  /// See more info: [selectedGroupNumber]
  static List<String> get getGroupNumbers {
    return List.generate(4, (index) => (index + 1).toString());
  }

  /// Returns a number identification of given group name, if
  /// group not found, then returns search error
  static String findGroupIdentification(String group) {
    return _groups[group] ?? 'Группа не найдена';
  }

  /// Updates data for forming a group, used in [ChooseGroupUI].
  ///
  /// [value] can be [String] and [bool] depends on [ChangedType].
  void onValueChanged(
    dynamic value, {
    required ChangedType type,
  }) {
    switch (type) {
      case ChangedType.groupName:
        selectedGroup = value; // value is a String
        break;
      case ChangedType.groupCourse:
        selectedCourse = value; // value is a String
        break;
      case ChangedType.groupNumber:
        selectedGroupNumber = value; // value is a String
        break;
      case ChangedType.accelerated:
        isAccelerated = value; // value is a bool
        break;
    }
    updateFormedGroup();
  }

  /// Returns the last two digits of the year of admission of this course
  String calculateYear(String inputCourse) {
    DateTime now = DateTime.now();
    // if month any until September, then year of admission
    // first course is prev, else this
    int year = now.month < 9 ? now.year : now.year + 1;
    // calculate year of admission of given course [inputCourse]
    year -= int.parse(inputCourse);

    return year.toString().substring(2);
  }

  /// Updates the formed group based on [selectedGroup],
  /// [selectedGroupNumber] and [selectedCourse]
  void updateFormedGroup() {
    String groupID = findGroupIdentification(selectedGroup);
    String groupYear = calculateYear(selectedCourse);
    String appendix = isAccelerated ? 'у' : '';

    formedGroup = '$groupID-'
        '$selectedGroupNumber-'
        '$groupYear'
        '$appendix';

    checkSaveButtonAvailable();
  }

  /// Checks whether the "save" button is available for use.
  /// If the group is not selected, then it does not work
  void checkSaveButtonAvailable() {
    isSaveButtonEnabled = selectedGroup != getGroupsNames.first;
    notifyListeners();
  }

  /// Saves formed group to Hive to future using in [ScheduleScreen]
  void saveFormedGroup(BuildContext context) {
    HiveHelper.saveValue(
      key: 'chosenGroup',
      value: formedGroup,
    );
    // close modal dialog
    Navigator.pop(context);
  }
}

/// Used in [GroupsData.onValueChanged] method.
///
/// [groupName] - the data in the name of the group has changed,
///
/// [groupCourse] - the data in the course of the group has changed,
///
/// [groupNumber] - the data in the number of the group has changed,
///
/// [accelerated] - the data in the accelerated type of the group has changed,
enum ChangedType {
  groupName,
  groupCourse,
  groupNumber,
  accelerated,
}
