import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum SearchMode { firstName, familyName, secondaryName, lesson, cabinet }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class TeachersLogic extends ChangeNotifier {
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('teacher_list').snapshots();
  SearchMode currentMode = SearchMode.familyName;
  String visibleTextMode = 'Искать среди фамилий';
  String documentField = 'familyName';

  void search(String searchText) {
    if (searchText.isNotEmpty) {
      String searchKey = searchText.capitalize();
      stream = FirebaseFirestore.instance
          .collection('teacher_list')
          .where(documentField, isGreaterThanOrEqualTo: searchKey)
          .where(documentField, isLessThan: searchKey + "\uf8ff")
          .snapshots();
    } else {
      stream =
          FirebaseFirestore.instance.collection('teacher_list').snapshots();
    }
    notifyListeners();
  }

  void setMode(SearchMode mode) {
    currentMode = mode;
    setVisibleText(mode);
    notifyListeners();
  }

  void setVisibleText(SearchMode mode) {
    switch (mode) {
      case SearchMode.firstName:
        visibleTextMode = 'Искать среди имён';
        documentField = 'firstName';
        break;
      case SearchMode.familyName:
        visibleTextMode = 'Искать среди фамилий';
        documentField = 'familyName';
        break;
      case SearchMode.secondaryName:
        visibleTextMode = 'Искать среди отчеств';
        documentField = 'secondaryName';
        break;
      case SearchMode.lesson:
        visibleTextMode = 'Искать среди предметов';
        documentField = 'lesson';
        break;
      case SearchMode.cabinet:
        visibleTextMode = 'Искать среди кабинетов';
        documentField = 'cabinet';
        break;
    }
  }
}