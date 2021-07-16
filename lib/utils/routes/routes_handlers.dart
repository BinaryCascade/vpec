import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';
import 'package:vpec/utils/hive_helper.dart';
import 'package:vpec/utils/routes/routes.dart';

import '../../splash.dart';
import '../../ui/screens/about_app/about_app_screen.dart';
import '../../ui/screens/admins_screen.dart';
import '../../ui/screens/bottom_bar/bottom_bar_logic.dart';
import '../../ui/screens/bottom_bar/bottom_bar_screen.dart';
import '../../ui/screens/cabinets_map/cabinets_map_logic.dart';
import '../../ui/screens/cabinets_map/cabinets_map_screen.dart';
import '../../ui/screens/documents_screen.dart';
import '../../ui/screens/entrant/entrant_screen.dart';
import '../../ui/screens/job_quiz/job_quiz_screen.dart';
import '../../ui/screens/settings/settings_screen.dart';
import '../../ui/screens/teachers/teachers_logic.dart';
import '../../ui/screens/teachers/teachers_screen.dart';
import '../../ui/screens/view_document/view_document_screen.dart';

Handler homeScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ChangeNotifierProvider(
      create: (_) => BottomBarLogic(),
      child: const SplashScreen(child: BottomBarScreen()));
});

Handler settingsScreenHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> params) {
  return const SettingsScreen();
});

Handler viewDocumentScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return const DocumentViewScreen();
});

Handler cabinetsScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return ChangeNotifierProvider(
      create: (_) => CabinetsMapLogic(), child: const CabinetsMapScreen());
});

Handler administrationScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return AdminScreen();
});

Handler teachersScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return ChangeNotifierProvider(
      create: (_) => TeachersLogic(), child: const TeacherScreen());
});

Handler aboutAppScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return const AboutAppScreen();
});

Handler jobQuizScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return const JobQuizScreen();
});

Handler documentsScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return const DocumentsScreen();
});

Handler entrantScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return const EntrantScreen();
});

Handler loginByURLHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? email = params['login']!.first;
  String? password = params['password']!.first;

  makeLogin(email, password).then((value) {
    HiveHelper.saveValue(key: 'isUserEntrant', value: 'false');
    if (SettingsLogic.getAccountMode() != UserMode.entrant) {
      Navigator.pushNamedAndRemoveUntil(context!, FluroRoutes.homeScreen, (route) => false);
    }
  });
});

Future<void> makeLogin(String? email, String? password) async {
  if (email != null && password != null) {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
