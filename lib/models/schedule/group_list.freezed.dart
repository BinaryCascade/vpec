// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'group_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupList _$GroupListFromJson(Map<String, dynamic> json) {
  return _GroupList.fromJson(json);
}

/// @nodoc
mixin _$GroupList {
  @JsonKey(name: 'groupList', required: true, disallowNullValue: true)
  List<String> get groupList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupListCopyWith<GroupList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupListCopyWith<$Res> {
  factory $GroupListCopyWith(GroupList value, $Res Function(GroupList) then) =
      _$GroupListCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'groupList', required: true, disallowNullValue: true)
          List<String> groupList});
}

/// @nodoc
class _$GroupListCopyWithImpl<$Res> implements $GroupListCopyWith<$Res> {
  _$GroupListCopyWithImpl(this._value, this._then);

  final GroupList _value;
  // ignore: unused_field
  final $Res Function(GroupList) _then;

  @override
  $Res call({
    Object? groupList = freezed,
  }) {
    return _then(_value.copyWith(
      groupList: groupList == freezed
          ? _value.groupList
          : groupList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$GroupListCopyWith<$Res> implements $GroupListCopyWith<$Res> {
  factory _$GroupListCopyWith(
          _GroupList value, $Res Function(_GroupList) then) =
      __$GroupListCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'groupList', required: true, disallowNullValue: true)
          List<String> groupList});
}

/// @nodoc
class __$GroupListCopyWithImpl<$Res> extends _$GroupListCopyWithImpl<$Res>
    implements _$GroupListCopyWith<$Res> {
  __$GroupListCopyWithImpl(_GroupList _value, $Res Function(_GroupList) _then)
      : super(_value, (v) => _then(v as _GroupList));

  @override
  _GroupList get _value => super._value as _GroupList;

  @override
  $Res call({
    Object? groupList = freezed,
  }) {
    return _then(_GroupList(
      groupList: groupList == freezed
          ? _value.groupList
          : groupList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GroupList implements _GroupList {
  const _$_GroupList(
      {@JsonKey(name: 'groupList', required: true, disallowNullValue: true)
          required final List<String> groupList})
      : _groupList = groupList;

  factory _$_GroupList.fromJson(Map<String, dynamic> json) =>
      _$$_GroupListFromJson(json);

  @JsonKey(name: 'groupList', required: true, disallowNullValue: true)
  final List<String> _groupList;
  @override
  @JsonKey(name: 'groupList', required: true, disallowNullValue: true)
  List<String> get groupList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupList);
  }

  @override
  String toString() {
    return 'GroupList(groupList: $groupList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupList &&
            const DeepCollectionEquality().equals(other.groupList, groupList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(groupList));

  @JsonKey(ignore: true)
  @override
  _$GroupListCopyWith<_GroupList> get copyWith =>
      __$GroupListCopyWithImpl<_GroupList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupListToJson(this);
  }
}

abstract class _GroupList implements GroupList {
  const factory _GroupList(
      {@JsonKey(name: 'groupList', required: true, disallowNullValue: true)
          required final List<String> groupList}) = _$_GroupList;

  factory _GroupList.fromJson(Map<String, dynamic> json) =
      _$_GroupList.fromJson;

  @override
  @JsonKey(name: 'groupList', required: true, disallowNullValue: true)
  List<String> get groupList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GroupListCopyWith<_GroupList> get copyWith =>
      throw _privateConstructorUsedError;
}
