import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/account_info.dart';
import 'hive_helper.dart';

/// Types of access level.
enum AccountType {
  /// Have access to view all announcements and edit mode.
  admin,

  /// can see announcements for students
  student,

  /// can see announcements for parents
  parent,

  /// can see announcements for teachers
  teacher,

  /// can't see anything except info about college
  entrant,
}

/// This class contains all information about account in [accountInfo].
/// [accountInfo] will be updated only after [startListening] function
/// was called. If listening no more needed, call [cancelListener].
///
/// Should be used with ChangeNotifierProvider.
class FirebaseAppAuth extends ChangeNotifier {
  AccountInfo accountInfo = AccountInfo(
    isLoggedIn: HiveHelper.getValue('isLoggedIn') ?? false,
    level: AccountType.entrant,
  );
  late StreamSubscription<User?> authListener;

  /// Start listening for user auth state changes.
  /// Call [cancelListener] to stop it.
  void startListening() {
    authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user?.email == null) {
        // user sign-out
        accountInfo = accountInfo.copyWith(
          isLoggedIn: false,
          level: AccountType.entrant,
        );

        HiveHelper.removeValue('isLoggedIn');
        notifyListeners();
      } else {
        // user sign-in
        accountInfo = accountInfo.copyWith(
          isLoggedIn: true,
          email: user!.email,
          uid: user.uid,
          name: HiveHelper.getValue('username'),
          level: AccountDetails.getAccountLevel,
        );

        HiveHelper.saveValue(key: 'isLoggedIn', value: true);
        notifyListeners();
      }
    });
  }

  /// Cancel listening for user auth state changes.
  Future<void> cancelListener() async {
    await authListener.cancel();
  }
}

/// This class used for storing and changing admin editor mode in-app.
/// Use [isInEditorMode] to get current status of editor mode.
///
/// Should be used with ChangeNotifierProvider.
class AccountEditorMode extends ChangeNotifier {
  bool isEditorModeActive = HiveHelper.getValue('isEditMode') ?? false;

  bool get isInEditorMode => AccountDetails.isAdmin && isEditorModeActive;

  /// Call this to on or off admin editor mode
  void toggleEditorMode() {
    isEditorModeActive = !isEditorModeActive;
    HiveHelper.saveValue(key: 'isEditMode', value: isEditorModeActive);
    notifyListeners();
  }
}

/// This class contains a functions for getting user's app-specific data
class AccountDetails {
  static bool get isAdmin => getAccountLevel == AccountType.admin;

  /// Call to get [AccountType] of current user.
  /// If user didn't sign-in, returns [AccountType.entrant]
  static AccountType get getAccountLevel {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      switch (auth.currentUser!.email) {
        case 'admin@energocollege.ru':
          return AccountType.admin;
        case 'parent@energocollege.ru':
          return AccountType.parent;
        case 'teacher@energocollege.ru':
          return AccountType.teacher;
        case 'student@energocollege.ru':
          return AccountType.student;
        default:
          throw 'Email of this account is not supported:\n${auth.currentUser!.email}';
      }
    } else {
      return AccountType.entrant;
    }
  }

  /// Call this function to find out
  /// if the user has access to the required [AccountType].
  static bool hasAccessToLevel(AccountType requestedType) {
    // get user account type and compare with requested type
    // admins always has access to something,
    // students, teachers and parents has access only for their account type.
    switch (getAccountLevel) {
      case AccountType.admin:
        return true;
      case AccountType.student:
        return requestedType == AccountType.student;
      case AccountType.teacher:
        return requestedType == AccountType.teacher;
      case AccountType.entrant:
        return requestedType == AccountType.entrant;
      case AccountType.parent:
        return requestedType == AccountType.parent;
      default:
        return false;
    }
  }

  /// Low level access account is account for students or entrant
  @Deprecated('Accounts no more uses different type of access levels')
  static bool get isAccountLowLevelAccess =>
      getAccountLevel == AccountType.student ||
              getAccountLevel == AccountType.entrant
          ? true
          : false;
}
