import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vpec/models/time_model.dart';

class TimeTableItemLogic extends ChangeNotifier {
  bool isCurrentItemNeedHighlight = false;

  void updateItem(TimeModel model) {
    DateTime now = DateTime.now();
    DateTime dateStartLesson = DateFormat('HH:mm').parse(model.startLesson);
    DateTime dateEndLesson = DateFormat('HH:mm').parse(model.endLesson);

    Duration nowDuration = Duration(hours: now.hour, minutes: now.minute);
    Duration durationStartLesson =
        Duration(hours: dateStartLesson.hour, minutes: dateStartLesson.minute);
    Duration durationEndLesson =
        Duration(hours: dateEndLesson.hour, minutes: dateEndLesson.minute);
  }
}
