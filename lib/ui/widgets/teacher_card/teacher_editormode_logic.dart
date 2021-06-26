import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/teacher_model.dart';
import '../../../ui/widgets/confirm_delete_dialog.dart';
import '../../../utils/rounded_modal_sheet.dart';
import 'teacher_editormode_ui.dart';

class TeacherEditorModeLogic {
  void showEditDialog(BuildContext context, TeacherModel model) {
    roundedModalSheet(
        context: context,
        title: 'Редактировать преподавателя',
        child: EditTeacherDialogUI(model: model));
  }

  void editTeacher(TeacherModel model) {
    CollectionReference teachers =
        FirebaseFirestore.instance.collection('teacher_list');
    teachers
        .doc(model.id)
        .set(
          model.toMap(int.parse(model.id!)),
        );
  }

  void showConfirmDeleteDialog(BuildContext context, String id) {
    Navigator.pop(context);
    roundedModalSheet(
        context: context,
        title: 'Подтвердите действие',
        child: DeleteDialogUI(onDelete: () => confirmDelete(id)));
  }

  void confirmDelete(String id) {
    CollectionReference teachers =
        FirebaseFirestore.instance.collection('teacher_list');
    teachers.doc(id).delete();
  }
}
