import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    @JsonKey(name: 'schedule', required: true, disallowNullValue: true)
        required Map<String, dynamic> scheduleMap,
  }) = _Schedule;

  /// Generate Class from Map<String, dynamic>
  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
