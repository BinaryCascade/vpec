import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/about_app/about_app_screen.dart';
import '/screens/bottom_bar/bottom_bar_logic.dart';
import '/screens/bottom_bar/bottom_bar_screen.dart';
import '/screens/cabinets_map/cabinets_map_screen.dart';
import '/screens/documents/documents_screen.dart';
import '/screens/job_quiz/job_quiz_screen.dart';
import '/screens/settings/settings_screen.dart';
import '/screens/teachers/teachers_logic.dart';
import '/screens/teachers/teachers_screen.dart';
import '/screens/view_document/view_document_screen.dart';
import '/splash.dart';
import '../../screens/admins/admins_screen.dart';
import '../../screens/lessons_schedule/lessons_schedule_screen.dart';
import 'routes.dart';

Handler homeScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return ChangeNotifierProvider(
      create: (_) => BottomBarLogic(),
      child: const SplashScreen(child: BottomBarScreen()),
    );
  },
);

Handler settingsScreenHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> params) {
  return const SettingsScreen();
});

Handler viewDocumentScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return const DocumentViewScreen();
  },
);

Handler cabinetsScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return const CabinetsMapScreen();
  },
);

Handler administrationScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return AdminScreen();
  },
);

Handler teachersScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return ChangeNotifierProvider(
      create: (_) => TeachersLogic(),
      child: const TeacherScreen(),
    );
  },
);

Handler aboutAppScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return const AboutAppScreen();
  },
);

Handler jobQuizScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return const JobQuizScreen();
  },
);

Handler documentsScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
    return const DocumentsScreen();
  },
);

Handler loginByURLHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    String? email = params['login']!.first;
    String? password = params['password']!.first;

    makeLogin(email, password).then((_) {
      Navigator.pushNamedAndRemoveUntil(
        context!,
        Routes.homeScreen,
        (route) => false,
      );
    });

    return null;
  },
);

Future<void> makeLogin(String? email, String? password) async {
  if (email != null && password != null) {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}

Handler fullScheduleScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const FullLessonsScheduleScreen(),
);