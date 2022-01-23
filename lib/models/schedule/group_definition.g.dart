// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupDefinition _$$_GroupDefinitionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['definition'],
    disallowNullValues: const ['definition'],
  );
  return _$_GroupDefinition(
    groupDefinitionMap: json['definition'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$$_GroupDefinitionToJson(_$_GroupDefinition instance) =>
    <String, dynamic>{
      'definition': instance.groupDefinitionMap,
    };
