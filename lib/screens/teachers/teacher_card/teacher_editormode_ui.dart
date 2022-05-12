import 'package:flutter/material.dart';

import '/models/teacher_model.dart';
import 'teacher_editormode_logic.dart';

class EditTeacherDialogUI extends StatefulWidget {
  final TeacherModel model;

  const EditTeacherDialogUI({Key? key, required this.model}) : super(key: key);

  @override
  State<EditTeacherDialogUI> createState() => _EditTeacherDialogUIState();
}

class _EditTeacherDialogUIState extends State<EditTeacherDialogUI> {
  TextEditingController firstName = TextEditingController();
  TextEditingController familyName = TextEditingController();
  TextEditingController secondaryName = TextEditingController();
  TextEditingController cabinet = TextEditingController();
  TextEditingController lessons = TextEditingController();

  @override
  void initState() {
    firstName.text = widget.model.firstName!;
    familyName.text = widget.model.familyName!;
    secondaryName.text = widget.model.secondaryName!;
    cabinet.text = widget.model.cabinet!;
    lessons.text = widget.model.lesson!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: familyName,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Фамилия'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: firstName,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Имя'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: secondaryName,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Отчество'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: lessons,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(labelText: 'Занятия'),
          ),
        ),
        TextFormField(
          controller: cabinet,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Кабинет'),
        ),
        ButtonBar(
          children: [
            TextButton(
              onPressed: () => TeacherEditorModeLogic.showConfirmDeleteDialog(
                context,
                widget.model.id!,
              ),
              child: const Text('Удалить'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                TeacherEditorModeLogic.editTeacher(TeacherModel(
                  firstName: firstName.text,
                  familyName: familyName.text,
                  secondaryName: secondaryName.text,
                  cabinet: cabinet.text,
                  lesson: lessons.text,
                  id: widget.model.id,
                ));
                Navigator.pop(context);
              },
              child: const Text('Редактировать'),
            ),
          ],
        ),
      ],
    );
  }
}
