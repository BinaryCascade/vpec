import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_item.freezed.dart';

@freezed
class ScheduleItemModel with _$ScheduleItemModel {
  const factory ScheduleItemModel({
    required int lessonNumber,
    required String lessonBeginning,
    required String lessonEnding,
    required String lessonName,
    required String pauseAfterLesson,

  }) = _ScheduleItemModel;
}
