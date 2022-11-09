import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/account_info.dart';
import 'hive_helper.dart';

/// Types of access level.
enum AccessLevel {
  /// Have access to view all announcements and edit mode.
  admin,

  /// can see only public announcements
  student,

  /// can see public and employee announcements
  employee,

  /// can see public and teachers announcements
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
    level: AccessLevel.entrant,
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
          level: AccessLevel.entrant,
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
          level: AccountDetails.getAccountLevel(),
          isLowLevel: AccountDetails.isAccountLowLevelAccess,
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

  bool get isInEditorMode =>
      AccountDetails.getAccountLevel() == AccessLevel.admin &&
      isEditorModeActive;

  /// Call this to on or off admin editor mode
  void toggleEditorMode() {
    isEditorModeActive = !isEditorModeActive;
    HiveHelper.saveValue(key: 'isEditMode', value: isEditorModeActive);
    notifyListeners();
  }
}

/// This class contains a functions for getting user's app-specific data
class AccountDetails {
  /// Call to get [AccessLevel] of current user.
  /// If user didn't sign-in, returns [AccessLevel.entrant]
  static AccessLevel getAccountLevel() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      switch (auth.currentUser!.email) {
        case 'admin@energocollege.ru':
          return AccessLevel.admin;
        case 'employee@energocollege.ru':
          return AccessLevel.employee;
        case 'teacher@energocollege.ru':
          return AccessLevel.teacher;
        case 'student@energocollege.ru':
          return AccessLevel.student;
        default:
          throw 'Email of this account is not supported:\n${auth.currentUser!.email}';
      }
    } else {
      return AccessLevel.entrant;
    }
  }

  /// Call this function to find out
  /// if the user has access to the required [AccessLevel].
  static bool hasAccessToLevel(AccessLevel requiredLevel) {
    switch (getAccountLevel()) {
      case AccessLevel.admin:
        return true; // admin have access to anything
      case AccessLevel.student:
        return requiredLevel == AccessLevel.entrant ||
                requiredLevel == AccessLevel.student
            ? true
            : false;
      case AccessLevel.employee:
        return requiredLevel == AccessLevel.employee ||
                requiredLevel == AccessLevel.student ||
                requiredLevel == AccessLevel.entrant
            ? true
            : false;
      case AccessLevel.teacher:
        return requiredLevel == AccessLevel.teacher ||
                requiredLevel == AccessLevel.student ||
                requiredLevel == AccessLevel.entrant
            ? true
            : false;
      case AccessLevel.entrant:
        return requiredLevel == AccessLevel.entrant ? true : false;
    }
  }

  /// Low level access account is account for students or entrant
  static bool get isAccountLowLevelAccess =>
      getAccountLevel() == AccessLevel.student ||
              getAccountLevel() == AccessLevel.entrant
          ? true
          : false;
}
