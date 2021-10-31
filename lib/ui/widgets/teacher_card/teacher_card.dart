import 'package:flutter/material.dart';
import 'package:vpec/screens/settings/settings_logic.dart';

import '../../../models/teacher_model.dart';
import '../../../ui/widgets/teacher_card/teacher_editormode_logic.dart';

class TeacherCard extends StatelessWidget {
  final TeacherModel teacher;

  const TeacherCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onDoubleTap: () {
          if (SettingsLogic.checkIsInEditMode) {
            TeacherEditorModeLogic().showEditDialog(context, teacher);
          }
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
