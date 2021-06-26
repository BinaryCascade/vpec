import 'package:flutter/material.dart';

import '../../../models/teacher_model.dart';
import 'teacher_editormode_logic.dart';

class EditTeacherDialogUI extends StatefulWidget {
  final TeacherModel model;

  const EditTeacherDialogUI({Key? key, required this.model}) : super(key: key);

  @override
  _EditTeacherDialogUIState createState() => _EditTeacherDialogUIState();
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
    return Wrap(
      runSpacing: 8.0,
      children: [
        TextFormField(
          controller: familyName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Фамилия',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: firstName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Имя',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: secondaryName,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Отчество',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: lessons,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Занятия',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: cabinet,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Кабинет',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ButtonBar(
            buttonPadding: EdgeInsets.zero,
            children: [
              Wrap(
                spacing: 12,
                children: [
                  TextButton(
                    onPressed: () => TeacherEditorModeLogic()
                        .showConfirmDeleteDialog(context, widget.model.id!),
                    child: Text(
                      'Удалить',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        TeacherEditorModeLogic().editTeacher(TeacherModel(
                          firstName: firstName.text,
                          familyName: familyName.text,
                          secondaryName: secondaryName.text,
                          cabinet: cabinet.text,
                          lesson: lessons.text,
                          id: widget.model.id,
                        ));
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Редактировать',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
