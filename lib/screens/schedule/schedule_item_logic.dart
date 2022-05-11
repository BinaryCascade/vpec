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
    required String? names,
    required String? lessonName,
  }) {
    open = !open;
    infoWidget = open
        ? AdditionalInfoPanelWidget(
            names: names ?? 'Нет данных о преподавателе',
            notes: HiveHelper.getValue('note_${unifyKeyMatching(lessonName)}'),
            lessonName: unifyKeyMatching(lessonName) ?? 'nothing',
          )
        : const SizedBox(width: double.infinity);

    notifyListeners();
  }

  /// Used for unify lessons keys for similar names,
  /// e.x: '[Ш] Иностранный язык' and '[П] Иностранный язык', 'Иностранный язык'
  /// is the same lesson.
  String? unifyKeyMatching(String? name) {
    // list with all lessons names to find matches
    List<String> matchList = [
      'Иностранный язык',
    ];

    if (name != null) {
      for (String element in matchList) {
        if (name.contains(element)) return element;
      }
    }

    return name;
  }
}
