import 'dart:async';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vpec/models/time_model.dart';

class TimeTableItemLogic extends ChangeNotifier {
  bool isCurrentItemNeedHighlight = true;
  Timer updateTimer = Timer(Duration(seconds: 0), (){});

  String updateTimeItem(TimeModel model) {

    DateTime now = DateTime.now();
    DateTime dateStartLesson = DateFormat('HH:mm').parse(model.startLesson);
    DateTime dateEndLesson = DateFormat('HH:mm').parse(model.endLesson);

    Duration nowDuration = Duration(hours: now.hour, minutes: now.minute);
    Duration durationStartLesson =
        Duration(hours: dateStartLesson.hour, minutes: dateStartLesson.minute);
    Duration durationEndLesson =
        Duration(hours: dateEndLesson.hour, minutes: dateEndLesson.minute);

    if (isCurrentItemNeedHighlight) {
      if (nowDuration >= durationStartLesson &&
          nowDuration < durationEndLesson) {
        isCurrentItemNeedHighlight = false;
        debugPrint('first method for ${model.name}');
        return 'До конца: ' +
            prettyDuration(durationEndLesson - nowDuration,
                locale: DurationLocale.fromLanguageCode('ru'));
      }
    }

    if (isCurrentItemNeedHighlight) {
      if (nowDuration < durationStartLesson) {
        isCurrentItemNeedHighlight = false;
        debugPrint('second method for ${model.name}');
        return 'До начала: ' +
            prettyDuration(durationStartLesson - nowDuration,
                locale: DurationLocale.fromLanguageCode('ru'));
      }
    }

    return '';
  }

  void cancelTimer() {
    updateTimer.cancel();
  }

  void updateTime() {
    updateTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      isCurrentItemNeedHighlight = true;
      notifyListeners();
    });
  }
}
