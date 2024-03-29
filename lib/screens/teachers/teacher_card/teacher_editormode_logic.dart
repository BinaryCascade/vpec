import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/models/teacher_model.dart';
import '/utils/utils.dart';
import '/widgets/confirm_delete_dialog.dart';
import 'teacher_editormode_ui.dart';

class TeacherEditorModeLogic {
  static void showEditDialog(BuildContext context, TeacherModel model) {
    showRoundedModalSheet(
      context: context,
      title: 'Редактировать преподавателя',
      child: EditTeacherDialogUI(model: model),
    );
  }

  static void editTeacher(TeacherModel model) {
    CollectionReference teachers =
        FirebaseFirestore.instance.collection('teacher_list');
    teachers.doc(model.id).set(
          model.toMap(int.parse(model.id!)),
        );
  }

  static void showConfirmDeleteDialog(BuildContext context, String id) {
    Navigator.pop(context);
    showRoundedModalSheet(
      context: context,
      title: 'Подтвердите действие',
      child: DeleteDialogUI(onDelete: () => confirmDelete(id)),
    );
  }

  static void confirmDelete(String id) {
    CollectionReference teachers =
        FirebaseFirestore.instance.collection('teacher_list');
    teachers.doc(id).delete();
  }
}
