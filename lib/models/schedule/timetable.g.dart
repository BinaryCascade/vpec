// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Timetable _$$_TimetableFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['timetable'],
    disallowNullValues: const ['timetable'],
  );
  return _$_Timetable(
    timetableMap: json['timetable'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$$_TimetableToJson(_$_Timetable instance) =>
    <String, dynamic>{
      'timetable': instance.timetableMap,
    };
