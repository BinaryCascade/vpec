// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupList _$$_GroupListFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['groupList'],
    disallowNullValues: const ['groupList'],
  );
  return _$_GroupList(
    groupList:
        (json['groupList'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$$_GroupListToJson(_$_GroupList instance) =>
    <String, dynamic>{
      'groupList': instance.groupList,
    };
