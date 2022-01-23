import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_list.freezed.dart';
part 'group_list.g.dart';

@freezed
class GroupList with _$GroupList {
  const factory GroupList({
    @JsonKey(
      name: 'groupList',
      required: true,
      disallowNullValue: true,
    )
        required List<String> groupList,
  }) = _GroupList;

  /// Generate Class from Map<String, dynamic>
  factory GroupList.fromJson(Map<String, dynamic> json) =>
      _$GroupListFromJson(json);
}
