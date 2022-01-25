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
    required Map<String, dynamic> teachers,
    required Map<String, dynamic> lessonsShortNames,
    required Map<String, dynamic> lessonsFullNames,

  }) = _ScheduleItemModel;
}
