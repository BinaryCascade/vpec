// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_definition.freezed.dart';
part 'group_definition.g.dart';

@freezed
class GroupDefinition with _$GroupDefinition {
  const factory GroupDefinition({
    @JsonKey(name: 'definition', required: true, disallowNullValue: true)
        required Map<String, dynamic> groupDefinitionMap,
  }) = _GroupDefinition;

  /// Generate Class from Map<String, dynamic>
  factory GroupDefinition.fromJson(Map<String, dynamic> json) =>
      _$GroupDefinitionFromJson(json);
}
