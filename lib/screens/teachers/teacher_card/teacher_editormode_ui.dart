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
        TextFormField(
          controller: familyName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Фамилия'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: firstName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Имя'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: secondaryName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Отчество'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: lessons,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Занятия'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: cabinet,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: const InputDecoration(labelText: 'Кабинет'),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
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
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => TeacherEditorModeLogic.showConfirmDeleteDialog(
                  context,
                  widget.model.id!,
                ),
                child: const Text('Удалить'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
