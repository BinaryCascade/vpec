import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_schedule.freezed.dart';

@freezed
class FullSchedule with _$FullSchedule {
  const factory FullSchedule({
    required String jsonData,
    required String groups,
    required Map<String, dynamic> schedule,
    required Map<String, dynamic> timetable,
    required Map<String, dynamic> shortLessonNames,
    required Map<String, dynamic> fullLessonNames,
    required Map<String, dynamic> teachers,
  }) = _FullSchedule;
}
