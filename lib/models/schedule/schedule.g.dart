// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Schedule _$$_ScheduleFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['schedule'],
    disallowNullValues: const ['schedule'],
  );
  return _$_Schedule(
    scheduleMap: json['schedule'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$$_ScheduleToJson(_$_Schedule instance) =>
    <String, dynamic>{
      'schedule': instance.scheduleMap,
    };
