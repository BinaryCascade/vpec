import 'dart:async';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/time_model.dart';
import '../../../utils/utils.dart';
import 'timetable_editormode_ui.dart';

class TimeTableItemLogic extends ChangeNotifier {
  bool needPrintText = true;
  Timer updateTimer = Timer(const Duration(seconds: 0), () {});
  Duration smallestUntilStartDuration = const Duration(days: 2);

  String updateTimeItem(TimeModel model) {
    DateTime now = DateTime.now();
    DateTime dateStartLesson = DateFormat('HH:mm').parse(model.startLesson!);
    DateTime dateEndLesson = DateFormat('HH:mm').parse(model.endLesson!);

    Duration nowDuration =
        Duration(hours: now.hour, minutes: now.minute, seconds: now.second);
    Duration startDuration =
        Duration(hours: dateStartLesson.hour, minutes: dateStartLesson.minute);
    Duration endDuration =
        Duration(hours: dateEndLesson.hour, minutes: dateEndLesson.minute);

    if (nowDuration >= startDuration && nowDuration < endDuration) {
      needPrintText = false;

      if (endDuration - nowDuration <= const Duration(seconds: 1)) {
        smallestUntilStartDuration = const Duration(days: 2);
        // updating with delay for user-invisible check
        updateAfterFewMoment();
      }

      return 'До конца: ' + printUntilDuration(endDuration - nowDuration);
    } else {
      if (nowDuration < startDuration && needPrintText) {
        if (startDuration - nowDuration <= smallestUntilStartDuration) {
          smallestUntilStartDuration = startDuration - nowDuration;
          return 'До начала: ' +
              printUntilDuration(startDuration - nowDuration);
        }
      }
    }

    return '';
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  void removeListener(VoidCallback listener) {
    cancelTimer();
    super.removeListener(listener);
  }

  Future<void> updateAfterFewMoment() async {
    await Future.delayed(const Duration(seconds: 1), () => needPrintText = true);
  }

  void cancelTimer() {
    updateTimer.cancel();
  }

  String printUntilDuration(Duration duration) {
    return prettyDuration(Duration(minutes: duration.inMinutes + 1),
        locale: const RussianDurationLanguage());
  }

  void updateTime() {
    cancelTimer();
    updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      notifyListeners();
    });
  }
}

class TimeTableEditorMode {
  void openTimeTableItemEdit(
      {required BuildContext context, required TimeModel model}) {
    roundedModalSheet(
        context: context,
        title: 'Редактировать: ${model.name}',
        child: EditTimeTableItemDialogUI(
          model: model,
        ));
  }
}
