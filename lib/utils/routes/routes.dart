import 'package:fluro/fluro.dart';

import 'routes_handlers.dart';

class Routes {
  static late FluroRouter router;

  static String homeScreen = '/';
  static String settingsScreen = '/settings';
  static String viewDocumentScreen = '/view_document';
  static String cabinetsScreen = '/cabinets';
  static String administrationScreen = '/administration';
  static String teachersScreen = '/teacher';
  static String aboutAppScreen = '/about';
  static String jobQuizScreen = '/job_quiz';
  static String documentsScreen = '/documents';
  static String loginByURLScreen = '/loginByURL/:login/:password';
  static String fullScheduleScreen = '/full_schedule';

  static void defineRoutes(FluroRouter router) {
    // router.notFoundHandler use for 404 page
    router.notFoundHandler = homeScreenHandler;

    router.define(homeScreen,
        handler: homeScreenHandler, transitionType: TransitionType.cupertino);
    router.define(settingsScreen,
        handler: settingsScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(viewDocumentScreen,
        handler: viewDocumentScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(cabinetsScreen,
        handler: cabinetsScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(administrationScreen,
        handler: administrationScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(teachersScreen,
        handler: teachersScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(aboutAppScreen,
        handler: aboutAppScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(jobQuizScreen,
        handler: jobQuizScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(documentsScreen,
        handler: documentsScreenHandler,
        transitionType: TransitionType.cupertino);
    router.define(loginByURLScreen,
        handler: loginByURLHandler, transitionType: TransitionType.cupertino);
    router.define(fullScheduleScreen,
        handler: fullScheduleScreenHandler,
        transitionType: TransitionType.cupertino);
  }
}
