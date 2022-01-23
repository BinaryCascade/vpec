// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timetable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Timetable _$TimetableFromJson(Map<String, dynamic> json) {
  return _Timetable.fromJson(json);
}

/// @nodoc
class _$TimetableTearOff {
  const _$TimetableTearOff();

  _Timetable call(
      {@JsonKey(name: 'timetable', required: true, disallowNullValue: true)
          required Map<String, dynamic> timetableMap}) {
    return _Timetable(
      timetableMap: timetableMap,
    );
  }

  Timetable fromJson(Map<String, Object?> json) {
    return Timetable.fromJson(json);
  }
}

/// @nodoc
const $Timetable = _$TimetableTearOff();

/// @nodoc
mixin _$Timetable {
  @JsonKey(name: 'timetable', required: true, disallowNullValue: true)
  Map<String, dynamic> get timetableMap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimetableCopyWith<Timetable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableCopyWith<$Res> {
  factory $TimetableCopyWith(Timetable value, $Res Function(Timetable) then) =
      _$TimetableCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'timetable', required: true, disallowNullValue: true)
          Map<String, dynamic> timetableMap});
}

/// @nodoc
class _$TimetableCopyWithImpl<$Res> implements $TimetableCopyWith<$Res> {
  _$TimetableCopyWithImpl(this._value, this._then);

  final Timetable _value;
  // ignore: unused_field
  final $Res Function(Timetable) _then;

  @override
  $Res call({
    Object? timetableMap = freezed,
  }) {
    return _then(_value.copyWith(
      timetableMap: timetableMap == freezed
          ? _value.timetableMap
          : timetableMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$TimetableCopyWith<$Res> implements $TimetableCopyWith<$Res> {
  factory _$TimetableCopyWith(
          _Timetable value, $Res Function(_Timetable) then) =
      __$TimetableCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'timetable', required: true, disallowNullValue: true)
          Map<String, dynamic> timetableMap});
}

/// @nodoc
class __$TimetableCopyWithImpl<$Res> extends _$TimetableCopyWithImpl<$Res>
    implements _$TimetableCopyWith<$Res> {
  __$TimetableCopyWithImpl(_Timetable _value, $Res Function(_Timetable) _then)
      : super(_value, (v) => _then(v as _Timetable));

  @override
  _Timetable get _value => super._value as _Timetable;

  @override
  $Res call({
    Object? timetableMap = freezed,
  }) {
    return _then(_Timetable(
      timetableMap: timetableMap == freezed
          ? _value.timetableMap
          : timetableMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Timetable implements _Timetable {
  const _$_Timetable(
      {@JsonKey(name: 'timetable', required: true, disallowNullValue: true)
          required this.timetableMap});

  factory _$_Timetable.fromJson(Map<String, dynamic> json) =>
      _$$_TimetableFromJson(json);

  @override
  @JsonKey(name: 'timetable', required: true, disallowNullValue: true)
  final Map<String, dynamic> timetableMap;

  @override
  String toString() {
    return 'Timetable(timetableMap: $timetableMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Timetable &&
            const DeepCollectionEquality()
                .equals(other.timetableMap, timetableMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(timetableMap));

  @JsonKey(ignore: true)
  @override
  _$TimetableCopyWith<_Timetable> get copyWith =>
      __$TimetableCopyWithImpl<_Timetable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimetableToJson(this);
  }
}

abstract class _Timetable implements Timetable {
  const factory _Timetable(
      {@JsonKey(name: 'timetable', required: true, disallowNullValue: true)
          required Map<String, dynamic> timetableMap}) = _$_Timetable;

  factory _Timetable.fromJson(Map<String, dynamic> json) =
      _$_Timetable.fromJson;

  @override
  @JsonKey(name: 'timetable', required: true, disallowNullValue: true)
  Map<String, dynamic> get timetableMap;
  @override
  @JsonKey(ignore: true)
  _$TimetableCopyWith<_Timetable> get copyWith =>
      throw _privateConstructorUsedError;
}
