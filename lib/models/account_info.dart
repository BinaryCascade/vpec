import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/firebase_auth.dart';

part 'account_info.freezed.dart';

@freezed
class AccountInfo with _$AccountInfo {
  const factory AccountInfo({
    required bool isLoggedIn,
    String? email,
    String? uid,
    String? name,
    required AccountType level,
  }) = _AccountInfo;
}
