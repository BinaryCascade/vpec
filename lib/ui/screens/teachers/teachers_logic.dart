import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/teacher_model.dart';
import '../../../utils/utils.dart';
import 'teachers_ui.dart';

enum SearchMode { firstName, familyName, secondaryName, lesson, cabinet }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class TeachersLogic extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      FirebaseFirestore.instance.collection('teacher_list').orderBy('familyName').snapshots();
  SearchMode currentMode = SearchMode.familyName;
  String visibleTextMode = 'Искать среди фамилий';
  String documentField = 'familyName';
  bool isSearchMode = false;

  void toggleSearch() {
    isSearchMode = !isSearchMode;
    notifyListeners();
  }

  void search(String searchText) {
    if (searchText.isNotEmpty) {
      String searchKey = searchText.capitalize();
      stream = FirebaseFirestore.instance
          .collection('teacher_list')
          .where(documentField, isGreaterThanOrEqualTo: searchKey)
          .where(documentField, isLessThan: searchKey + "\uf8ff")
          .snapshots();
    } else {
      stream = FirebaseFirestore.instance
          .collection('teacher_list')
          .orderBy('familyName')
          .snapshots();
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

class TeachersLogicEditMode {
  void openAddNewDialog(BuildContext context) {
    roundedModalSheet(
        context: context,
        title: 'Добавить преподавателя',
        child: const AddNewTeacherDialogUI());
  }

  void addNewTeacher(TeacherModel model) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection('teacher_list');

    int docID = DateTime.now().millisecondsSinceEpoch;
    schedule.doc(docID.toString()).set(model.toMap(docID));
  }
}
