import 'package:flutter/material.dart';

import '../../utils/hive_helper.dart';
import 'schedule_ui.dart';

class ScheduleItemLogic extends ChangeNotifier {
  bool open = false;
  Widget infoWidget = const SizedBox(
    width: double.infinity,
  );

  void toggleWidget(
    BuildContext context, {
    required String? names,
    required String? lessonName,
  }) {
    open = !open;
    if (open) {
      infoWidget = AdditionalInfoPanelWidget(
        names: names ?? 'Нет данных о преподавателе',
        notes: HiveHelper.getValue('note_$lessonName') ?? '',
        lessonName: lessonName ?? 'nothing',
      );
    } else {
      infoWidget = const SizedBox(
        width: double.infinity,
      );
    }

    notifyListeners();
  }
}
