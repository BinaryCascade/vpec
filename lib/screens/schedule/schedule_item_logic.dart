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
            notes: HiveHelper.getValue('note_$lessonName') ?? '',
            lessonName: lessonName ?? 'nothing',
          )
        : const SizedBox(width: double.infinity);

    notifyListeners();
  }
}
