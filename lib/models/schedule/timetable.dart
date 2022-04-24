// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'timetable.freezed.dart';
part 'timetable.g.dart';

@freezed
class Timetable with _$Timetable {
  const factory Timetable({
    @JsonKey(name: 'timetable', required: true, disallowNullValue: true)
        required Map<String, dynamic> timetableMap,
  }) = _Timetable;

  /// Generate Class from Map<String, dynamic>
  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);
}
