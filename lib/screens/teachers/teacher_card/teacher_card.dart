import 'package:flutter/material.dart';

import '/models/teacher_model.dart';
import '../../../utils/firebase_auth.dart';
import 'teacher_editormode_logic.dart';

class TeacherCard extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onDoubleTap: () {
          if (AccountEditorMode().isEditorModeActive) {
            TeacherEditorModeLogic.showEditDialog(context, teacher);
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    teacher.fullName!,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    teacher.lesson!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    if (teacher.cabinet != '')
                      Text(
                        "Кабинет ${teacher.cabinet}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
