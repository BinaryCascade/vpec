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
  AccountType get level => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountInfoCopyWith<AccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountInfoCopyWith<$Res> {
  factory $AccountInfoCopyWith(
          AccountInfo value, $Res Function(AccountInfo) then) =
      _$AccountInfoCopyWithImpl<$Res, AccountInfo>;
  @useResult
  $Res call(
      {bool isLoggedIn,
      String? email,
      String? uid,
      String? name,
      AccountType level});
}

/// @nodoc
class _$AccountInfoCopyWithImpl<$Res, $Val extends AccountInfo>
    implements $AccountInfoCopyWith<$Res> {
  _$AccountInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoggedIn = null,
    Object? email = freezed,
    Object? uid = freezed,
    Object? name = freezed,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as AccountType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountInfoCopyWith<$Res>
    implements $AccountInfoCopyWith<$Res> {
  factory _$$_AccountInfoCopyWith(
          _$_AccountInfo value, $Res Function(_$_AccountInfo) then) =
      __$$_AccountInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoggedIn,
      String? email,
      String? uid,
      String? name,
      AccountType level});
}

/// @nodoc
class __$$_AccountInfoCopyWithImpl<$Res>
    extends _$AccountInfoCopyWithImpl<$Res, _$_AccountInfo>
    implements _$$_AccountInfoCopyWith<$Res> {
  __$$_AccountInfoCopyWithImpl(
      _$_AccountInfo _value, $Res Function(_$_AccountInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoggedIn = null,
    Object? email = freezed,
    Object? uid = freezed,
    Object? name = freezed,
    Object? level = null,
  }) {
    return _then(_$_AccountInfo(
      isLoggedIn: null == isLoggedIn
          ? _value.isLoggedIn
          : isLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as AccountType,
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
      required this.level});

  @override
  final bool isLoggedIn;
  @override
  final String? email;
  @override
  final String? uid;
  @override
  final String? name;
  @override
  final AccountType level;

  @override
  String toString() {
    return 'AccountInfo(isLoggedIn: $isLoggedIn, email: $email, uid: $uid, name: $name, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountInfo &&
            (identical(other.isLoggedIn, isLoggedIn) ||
                other.isLoggedIn == isLoggedIn) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.level, level) || other.level == level));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoggedIn, email, uid, name, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountInfoCopyWith<_$_AccountInfo> get copyWith =>
      __$$_AccountInfoCopyWithImpl<_$_AccountInfo>(this, _$identity);
}

abstract class _AccountInfo implements AccountInfo {
  const factory _AccountInfo(
      {required final bool isLoggedIn,
      final String? email,
      final String? uid,
      final String? name,
      required final AccountType level}) = _$_AccountInfo;

  @override
  bool get isLoggedIn;
  @override
  String? get email;
  @override
  String? get uid;
  @override
  String? get name;
  @override
  AccountType get level;
  @override
  @JsonKey(ignore: true)
  _$$_AccountInfoCopyWith<_$_AccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
