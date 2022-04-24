// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return _Schedule.fromJson(json);
}

/// @nodoc
mixin _$Schedule {
  @JsonKey(name: 'schedule', required: true, disallowNullValue: true)
  Map<String, dynamic> get scheduleMap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScheduleCopyWith<Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCopyWith<$Res> {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) then) =
      _$ScheduleCopyWithImpl<$Res>;

  $Res call(
      {@JsonKey(name: 'schedule', required: true, disallowNullValue: true)
          Map<String, dynamic> scheduleMap});
}

/// @nodoc
class _$ScheduleCopyWithImpl<$Res> implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._value, this._then);

  final Schedule _value;

  // ignore: unused_field
  final $Res Function(Schedule) _then;

  @override
  $Res call({
    Object? scheduleMap = freezed,
  }) {
    return _then(_value.copyWith(
      scheduleMap: scheduleMap == freezed
          ? _value.scheduleMap
          : scheduleMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$ScheduleCopyWith(_Schedule value, $Res Function(_Schedule) then) =
      __$ScheduleCopyWithImpl<$Res>;

  @override
  $Res call(
      {@JsonKey(name: 'schedule', required: true, disallowNullValue: true)
          Map<String, dynamic> scheduleMap});
}

/// @nodoc
class __$ScheduleCopyWithImpl<$Res> extends _$ScheduleCopyWithImpl<$Res>
    implements _$ScheduleCopyWith<$Res> {
  __$ScheduleCopyWithImpl(_Schedule _value, $Res Function(_Schedule) _then)
      : super(_value, (v) => _then(v as _Schedule));

  @override
  _Schedule get _value => super._value as _Schedule;

  @override
  $Res call({
    Object? scheduleMap = freezed,
  }) {
    return _then(_Schedule(
      scheduleMap: scheduleMap == freezed
          ? _value.scheduleMap
          : scheduleMap // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Schedule implements _Schedule {
  const _$_Schedule(
      {@JsonKey(name: 'schedule', required: true, disallowNullValue: true)
          required final Map<String, dynamic> scheduleMap})
      : _scheduleMap = scheduleMap;

  factory _$_Schedule.fromJson(Map<String, dynamic> json) =>
      _$$_ScheduleFromJson(json);

  @JsonKey(name: 'schedule', required: true, disallowNullValue: true)
  final Map<String, dynamic> _scheduleMap;

  @override
  @JsonKey(name: 'schedule', required: true, disallowNullValue: true)
  Map<String, dynamic> get scheduleMap {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_scheduleMap);
  }

  @override
  String toString() {
    return 'Schedule(scheduleMap: $scheduleMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Schedule &&
            const DeepCollectionEquality()
                .equals(other.scheduleMap, scheduleMap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(scheduleMap));

  @JsonKey(ignore: true)
  @override
  _$ScheduleCopyWith<_Schedule> get copyWith =>
      __$ScheduleCopyWithImpl<_Schedule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScheduleToJson(this);
  }
}

abstract class _Schedule implements Schedule {
  const factory _Schedule(
      {@JsonKey(name: 'schedule', required: true, disallowNullValue: true)
          required final Map<String, dynamic> scheduleMap}) = _$_Schedule;

  factory _Schedule.fromJson(Map<String, dynamic> json) = _$_Schedule.fromJson;

  @override
  @JsonKey(name: 'schedule', required: true, disallowNullValue: true)
  Map<String, dynamic> get scheduleMap => throw _privateConstructorUsedError;

  @override
  @JsonKey(ignore: true)
  _$ScheduleCopyWith<_Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}
