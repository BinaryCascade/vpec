// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'account_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountInfo {
  bool get isLoggedIn => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  AccessLevel get level => throw _privateConstructorUsedError;
  bool? get isLowLevel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountInfoCopyWith<AccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountInfoCopyWith<$Res> {
  factory $AccountInfoCopyWith(
          AccountInfo value, $Res Function(AccountInfo) then) =
      _$AccountInfoCopyWithImpl<$Res>;
  $Res call(
      {bool isLoggedIn,
      String? email,
      String? uid,
      String? name,
      AccessLevel level,
      bool? isLowLevel});
}

/// @nodoc
class _$AccountInfoCopyWithImpl<$Res> implements $AccountInfoCopyWith<$Res> {
  _$AccountInfoCopyWithImpl(this._value, this._then);

  final AccountInfo _value;
  // ignore: unused_field
  final $Res Function(AccountInfo) _then;

  @override
  $Res call({
    Object? isLoggedIn = freezed,
    Object? email = freezed,
    Object? uid = freezed,
    Object? name = freezed,
    Object? level = freezed,
    Object? isLowLevel = freezed,
  }) {
    return _then(_value.copyWith(
      isLoggedIn: isLoggedIn == freezed
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as AccessLevel,
      isLowLevel: isLowLevel == freezed
          ? _value.isLowLevel
          : isLowLevel // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$AccountInfoCopyWith<$Res>
    implements $AccountInfoCopyWith<$Res> {
  factory _$AccountInfoCopyWith(
          _AccountInfo value, $Res Function(_AccountInfo) then) =
      __$AccountInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoggedIn,
      String? email,
      String? uid,
      String? name,
      AccessLevel level,
      bool? isLowLevel});
}

/// @nodoc
class __$AccountInfoCopyWithImpl<$Res> extends _$AccountInfoCopyWithImpl<$Res>
    implements _$AccountInfoCopyWith<$Res> {
  __$AccountInfoCopyWithImpl(
      _AccountInfo _value, $Res Function(_AccountInfo) _then)
      : super(_value, (v) => _then(v as _AccountInfo));

  @override
  _AccountInfo get _value => super._value as _AccountInfo;

  @override
  $Res call({
    Object? isLoggedIn = freezed,
    Object? email = freezed,
    Object? uid = freezed,
    Object? name = freezed,
    Object? level = freezed,
    Object? isLowLevel = freezed,
  }) {
    return _then(_AccountInfo(
      isLoggedIn: isLoggedIn == freezed
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as AccessLevel,
      isLowLevel: isLowLevel == freezed
          ? _value.isLowLevel
          : isLowLevel // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_AccountInfo implements _AccountInfo {
  const _$_AccountInfo(
      {required this.isLoggedIn,
      this.email,
      this.uid,
      this.name,
      required this.level,
      this.isLowLevel});

  @override
  final bool isLoggedIn;
  @override
  final String? email;
  @override
  final String? uid;
  @override
  final String? name;
  @override
  final AccessLevel level;
  @override
  final bool? isLowLevel;

  @override
  String toString() {
    return 'AccountInfo(isLoggedIn: $isLoggedIn, email: $email, uid: $uid, name: $name, level: $level, isLowLevel: $isLowLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccountInfo &&
            const DeepCollectionEquality()
                .equals(other.isLoggedIn, isLoggedIn) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality()
                .equals(other.isLowLevel, isLowLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoggedIn),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(isLowLevel));

  @JsonKey(ignore: true)
  @override
  _$AccountInfoCopyWith<_AccountInfo> get copyWith =>
      __$AccountInfoCopyWithImpl<_AccountInfo>(this, _$identity);
}

abstract class _AccountInfo implements AccountInfo {
  const factory _AccountInfo(
      {required final bool isLoggedIn,
      final String? email,
      final String? uid,
      final String? name,
      required final AccessLevel level,
      final bool? isLowLevel}) = _$_AccountInfo;

  @override
  bool get isLoggedIn => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  String? get uid => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  AccessLevel get level => throw _privateConstructorUsedError;
  @override
  bool? get isLowLevel => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AccountInfoCopyWith<_AccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
