import 'dart:async';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/time_model.dart';

class TimeTableItemLogic extends ChangeNotifier {
  bool needPrintText = true;
  Timer updateTimer = Timer(Duration(seconds: 0), () {});
  Duration nowDuration = Duration();
  Duration startDuration = Duration();
  Duration endDuration = Duration();
  Duration smallestUntilStartDuration = Duration(days: 2);

  String updateTimeItem(TimeModel model) {
    DateTime now = DateTime.now();
    DateTime dateStartLesson = DateFormat('HH:mm').parse(model.startLesson);
    DateTime dateEndLesson = DateFormat('HH:mm').parse(model.endLesson);

    nowDuration = Duration(hours: now.hour, minutes: now.minute);
    startDuration =
        Duration(hours: dateStartLesson.hour, minutes: dateStartLesson.minute);
    endDuration =
        Duration(hours: dateEndLesson.hour, minutes: dateEndLesson.minute);

    if (nowDuration >= startDuration && nowDuration < endDuration) {
      needPrintText = false;

      if (endDuration - nowDuration <= Duration(minutes: 1)) {
        smallestUntilStartDuration = Duration(days: 2);
         updateAfterFewMoment();
      }

      return 'До конца: ' +
          prettyDuration(endDuration - nowDuration,
              locale: DurationLocale.fromLanguageCode('ru'));
    } else {
      if (nowDuration < startDuration && needPrintText) {
        if (startDuration - nowDuration <= smallestUntilStartDuration) {
          smallestUntilStartDuration = startDuration - nowDuration;
          return 'До начала: ' +
              prettyDuration(startDuration - nowDuration,
                  locale: DurationLocale.fromLanguageCode('ru'));
        } else {
          return '';
        }
      } else {
        return '';
      }
    }
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
    await Future.delayed(Duration(minutes: 1), () => needPrintText = true);
  }

  void cancelTimer() {
    updateTimer.cancel();
  }

  void updateTime() {
    cancelTimer();
    updateTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      notifyListeners();
    });
  }
}
