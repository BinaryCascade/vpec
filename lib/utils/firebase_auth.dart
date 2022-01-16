import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'hive_helper.dart';

enum UserLevel {
  admin, // have access to view all announcements and edit mode
  student, // can see only public announcements
  employee, // can see public and employee announcements
  teacher, // can see public and teachers announcements
  entrant, // can't see anything except info about college
}

class UserInfo {
  bool isLoggedIn;
  String? email;
  String? uid;
  String? name;
  UserLevel? level;
  bool? isLowLevel;
  bool isEditMode;

  UserInfo({
    required this.isLoggedIn,
    this.email,
    this.uid,
    this.name,
    this.level,
    this.isLowLevel,
    required this.isEditMode,
  });
}

class FirebaseAppAuth extends ChangeNotifier {
  bool isLoggedIn = false;
  late StreamSubscription<User?> authListener;

  void startListening() {
    authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user?.email == null) {
        isLoggedIn = false;
        notifyListeners();
      } else {
        isLoggedIn = true;
        notifyListeners();
      }
    });
  }

  Future<void> cancelListener() async {
    await authListener.cancel();
  }
}

class AccountEditorMode extends ChangeNotifier {
  bool isEditModeActive = HiveHelper.getValue('isEditMode') ?? false;

  void toggleEditMode() {
    isEditModeActive = !isEditModeActive;
    HiveHelper.saveValue(key: 'isEditMode', value: isEditModeActive);
  }
}

class AccountDetails {
  static UserLevel getAccountLevel() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      switch (auth.currentUser!.email) {
        case 'admin@energocollege.ru':
          return UserLevel.admin;
        case 'employee@energocollege.ru':
          return UserLevel.employee;
        case 'teacher@energocollege.ru':
          return UserLevel.teacher;
        case 'student@energocollege.ru':
          return UserLevel.student;
        default:
          throw 'Email of this account is not supported:\n${auth.currentUser!.email}';
      }
    } else {
      return UserLevel.entrant;
    }
  }

  static bool hasAccessToLevel(UserLevel requiredLevel) {
    switch (getAccountLevel()) {
      case UserLevel.admin:
        return true; // admin have access to anything
      case UserLevel.student:
        if (requiredLevel == UserLevel.entrant ||
            requiredLevel == UserLevel.student) {
          return true; // students can see stuffs for entrant and students
        } else {
          return false;
        }
      case UserLevel.employee:
        if (requiredLevel == UserLevel.employee ||
            requiredLevel == UserLevel.student ||
            requiredLevel == UserLevel.entrant) {
          return true;
          // employee can see stuffs only for employee, not for teachers or admin
        } else {
          return false;
        }
      case UserLevel.teacher:
        if (requiredLevel == UserLevel.teacher ||
            requiredLevel == UserLevel.student ||
            requiredLevel == UserLevel.entrant) {
          return true;
          // teachers can see stuffs only for teachers, not for employee or admin
        } else {
          return false;
        }
      case UserLevel.entrant:
        if (requiredLevel == UserLevel.entrant) {
          return true;
          // well... entrant can see something only for entrant
        } else {
          return false;
        }
    }
  }

  static bool get isAccountLowLevel => getAccountLevel() == UserLevel.student ||
          getAccountLevel() == UserLevel.entrant
      ? true
      : false;
}
