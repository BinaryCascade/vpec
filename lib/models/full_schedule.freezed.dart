// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'full_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FullSchedule {
  List<String?> get timers => throw _privateConstructorUsedError;
  String get groups => throw _privateConstructorUsedError;
  Map<String, dynamic> get schedule => throw _privateConstructorUsedError;
  Map<String, dynamic> get timetable => throw _privateConstructorUsedError;
  Map<String, dynamic> get shortLessonNames =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get fullLessonNames =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get teachers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FullScheduleCopyWith<FullSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullScheduleCopyWith<$Res> {
  factory $FullScheduleCopyWith(
          FullSchedule value, $Res Function(FullSchedule) then) =
      _$FullScheduleCopyWithImpl<$Res, FullSchedule>;
  @useResult
  $Res call(
      {List<String?> timers,
      String groups,
      Map<String, dynamic> schedule,
      Map<String, dynamic> timetable,
      Map<String, dynamic> shortLessonNames,
      Map<String, dynamic> fullLessonNames,
      Map<String, dynamic> teachers});
}

/// @nodoc
class _$FullScheduleCopyWithImpl<$Res, $Val extends FullSchedule>
    implements $FullScheduleCopyWith<$Res> {
  _$FullScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timers = null,
    Object? groups = null,
    Object? schedule = null,
    Object? timetable = null,
    Object? shortLessonNames = null,
    Object? fullLessonNames = null,
    Object? teachers = null,
  }) {
    return _then(_value.copyWith(
      timers: null == timers
          ? _value.timers
          : timers // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timetable: null == timetable
          ? _value.timetable
          : timetable // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      shortLessonNames: null == shortLessonNames
          ? _value.shortLessonNames
          : shortLessonNames // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      fullLessonNames: null == fullLessonNames
          ? _value.fullLessonNames
          : fullLessonNames // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      teachers: null == teachers
          ? _value.teachers
          : teachers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FullScheduleCopyWith<$Res>
    implements $FullScheduleCopyWith<$Res> {
  factory _$$_FullScheduleCopyWith(
          _$_FullSchedule value, $Res Function(_$_FullSchedule) then) =
      __$$_FullScheduleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String?> timers,
      String groups,
      Map<String, dynamic> schedule,
      Map<String, dynamic> timetable,
      Map<String, dynamic> shortLessonNames,
      Map<String, dynamic> fullLessonNames,
      Map<String, dynamic> teachers});
}

/// @nodoc
class __$$_FullScheduleCopyWithImpl<$Res>
    extends _$FullScheduleCopyWithImpl<$Res, _$_FullSchedule>
    implements _$$_FullScheduleCopyWith<$Res> {
  __$$_FullScheduleCopyWithImpl(
      _$_FullSchedule _value, $Res Function(_$_FullSchedule) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timers = null,
    Object? groups = null,
    Object? schedule = null,
    Object? timetable = null,
    Object? shortLessonNames = null,
    Object? fullLessonNames = null,
    Object? teachers = null,
  }) {
    return _then(_$_FullSchedule(
      timers: null == timers
          ? _value._timers
          : timers // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as String,
      schedule: null == schedule
          ? _value._schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      timetable: null == timetable
          ? _value._timetable
          : timetable // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      shortLessonNames: null == shortLessonNames
          ? _value._shortLessonNames
          : shortLessonNames // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      fullLessonNames: null == fullLessonNames
          ? _value._fullLessonNames
          : fullLessonNames // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      teachers: null == teachers
          ? _value._teachers
          : teachers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_FullSchedule implements _FullSchedule {
  const _$_FullSchedule(
      {final List<String?> timers = const [],
      required this.groups,
      required final Map<String, dynamic> schedule,
      required final Map<String, dynamic> timetable,
      required final Map<String, dynamic> shortLessonNames,
      required final Map<String, dynamic> fullLessonNames,
      required final Map<String, dynamic> teachers})
      : _timers = timers,
        _schedule = schedule,
        _timetable = timetable,
        _shortLessonNames = shortLessonNames,
        _fullLessonNames = fullLessonNames,
        _teachers = teachers;

  final List<String?> _timers;
  @override
  @JsonKey()
  List<String?> get timers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timers);
  }

  @override
  final String groups;
  final Map<String, dynamic> _schedule;
  @override
  Map<String, dynamic> get schedule {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_schedule);
  }

  final Map<String, dynamic> _timetable;
  @override
  Map<String, dynamic> get timetable {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_timetable);
  }

  final Map<String, dynamic> _shortLessonNames;
  @override
  Map<String, dynamic> get shortLessonNames {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_shortLessonNames);
  }

  final Map<String, dynamic> _fullLessonNames;
  @override
  Map<String, dynamic> get fullLessonNames {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fullLessonNames);
  }

  final Map<String, dynamic> _teachers;
  @override
  Map<String, dynamic> get teachers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_teachers);
  }

  @override
  String toString() {
    return 'FullSchedule(timers: $timers, groups: $groups, schedule: $schedule, timetable: $timetable, shortLessonNames: $shortLessonNames, fullLessonNames: $fullLessonNames, teachers: $teachers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FullSchedule &&
            const DeepCollectionEquality().equals(other._timers, _timers) &&
            (identical(other.groups, groups) || other.groups == groups) &&
            const DeepCollectionEquality().equals(other._schedule, _schedule) &&
            const DeepCollectionEquality()
                .equals(other._timetable, _timetable) &&
            const DeepCollectionEquality()
                .equals(other._shortLessonNames, _shortLessonNames) &&
            const DeepCollectionEquality()
                .equals(other._fullLessonNames, _fullLessonNames) &&
            const DeepCollectionEquality().equals(other._teachers, _teachers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_timers),
      groups,
      const DeepCollectionEquality().hash(_schedule),
      const DeepCollectionEquality().hash(_timetable),
      const DeepCollectionEquality().hash(_shortLessonNames),
      const DeepCollectionEquality().hash(_fullLessonNames),
      const DeepCollectionEquality().hash(_teachers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FullScheduleCopyWith<_$_FullSchedule> get copyWith =>
      __$$_FullScheduleCopyWithImpl<_$_FullSchedule>(this, _$identity);
}

abstract class _FullSchedule implements FullSchedule {
  const factory _FullSchedule(
      {final List<String?> timers,
      required final String groups,
      required final Map<String, dynamic> schedule,
      required final Map<String, dynamic> timetable,
      required final Map<String, dynamic> shortLessonNames,
      required final Map<String, dynamic> fullLessonNames,
      required final Map<String, dynamic> teachers}) = _$_FullSchedule;

  @override
  List<String?> get timers;
  @override
  String get groups;
  @override
  Map<String, dynamic> get schedule;
  @override
  Map<String, dynamic> get timetable;
  @override
  Map<String, dynamic> get shortLessonNames;
  @override
  Map<String, dynamic> get fullLessonNames;
  @override
  Map<String, dynamic> get teachers;
  @override
  @JsonKey(ignore: true)
  _$$_FullScheduleCopyWith<_$_FullSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}
