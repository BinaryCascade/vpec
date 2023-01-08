import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../utils/hive_helper.dart';
import 'schedule_ui.dart';

class ScheduleItemLogic extends ChangeNotifier {
  /// Indicates whether widget is opened or closed
  bool open = false;

  /// The widget, used in [AdditionalInfo] as child for AnimatedSize
  Widget infoWidget = const SizedBox(
    width: double.infinity,
  );

  /// Used for open or close additional info for item in [SchedulePanel]
  void toggleAdditionalInfo({
    required Map<String, dynamic> names,
    required Map<String, dynamic> lessonFullNames,
    required String lessonName,
  }) {
    open = !open;
    infoWidget = open
        ? AdditionalInfoPanelWidget(
            key: const ValueKey('additional_info'),
            names: findTeacher(
              teachers: names,
              fullLessonName: lessonName,
              lessonFullNames: lessonFullNames,
            ),
            notes: HiveHelper.getValue('note_${unifyKeyMatching(lessonName)}'),
            lessonName: unifyKeyMatching(lessonName),
          )
        : const SizedBox(key: ValueKey('empty_space'), width: double.infinity);

    FirebaseAnalytics.instance.logEvent(name: 'schedule_additional_info', parameters: {
      'lesson_name': unifyKeyMatching(lessonName),
      'teacher': findTeacher(
        teachers: names,
        fullLessonName: lessonName,
        lessonFullNames: lessonFullNames,
      ),
    });
    notifyListeners();
  }

  /// Used for unify lessons keys for similar names,
  /// e.x: '[Ш] Иностранный язык' and '[П] Иностранный язык', 'Иностранный язык'
  /// is the same lesson.
  String unifyKeyMatching(String name) {
    // list with all lessons names to find matches
    List<String> matchList = [
      'Иностранный язык',
    ];

    for (String element in matchList) {
      if (name.contains(element)) return element;
    }

    return name;
  }

  /// Finds the name of the teacher for [fullLessonName].
  ///
  /// Full names should be provided in [lessonFullNames].
  ///
  /// Teachers should be provided in [teachers].
  ///
  /// [shortLessonName] is a name of the lesson to replace.
  ///
  ///
  ///
  /// The order of the items in [lessonFullNames] and [teachers]
  /// should be the same.
  static String findTeacher({
    required String fullLessonName,
    required Map<String, dynamic> lessonFullNames,
    required Map<String, dynamic> teachers,
  }) {
    String toReturn = '';
    // парсим первую пару из дележек
    if (fullLessonName.contains('①')) {
      int start = fullLessonName.indexOf('①') + 1;
      int? end = fullLessonName.lastIndexOf('②');
      if (end == -1) end = null;
      String lesson = fullLessonName.substring(start, end).trim();
      lesson = lessonFullNames.containsValue(lesson)
          ? teachers[lessonFullNames.keys.firstWhere((k) => lessonFullNames[k] == lesson)]
          : 'Нет данных о преподавателе';
      toReturn = '① $lesson';
    }

    // парсим вторую пару из дележек
    if (fullLessonName.contains('②')) {
      int start = fullLessonName.indexOf('②') + 1;
      String lesson = fullLessonName.substring(start).trim();
      lesson = lessonFullNames.containsValue(lesson)
          ? teachers[lessonFullNames.keys.firstWhere((k) => lessonFullNames[k] == lesson)]
          : 'Нет данных о преподавателе';
      toReturn =
          '$toReturn\n② $lesson';
    }

    return toReturn.isEmpty
        ? lessonFullNames.containsValue(fullLessonName)
        ? teachers[lessonFullNames.keys.firstWhere((k) => lessonFullNames[k] == fullLessonName)]
        : 'Нет данных о преподавателе'
        : toReturn.trim();
  }
}
