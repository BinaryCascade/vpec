import 'package:flutter/material.dart';

import '../../../models/time_model.dart';
import '../../../ui/screens/timetable/timetable_logic.dart';

class EditTimeTableItemDialogUI extends StatefulWidget {
  final TimeModel model;

  const EditTimeTableItemDialogUI({Key? key, required this.model})
      : super(key: key);

  @override
  _EditTimeTableItemDialogUIState createState() =>
      _EditTimeTableItemDialogUIState();
}

class _EditTimeTableItemDialogUIState extends State<EditTimeTableItemDialogUI> {
  TextEditingController name = TextEditingController();
  TextEditingController startLesson = TextEditingController();
  TextEditingController endLesson = TextEditingController();
  TextEditingController pause = TextEditingController();
  bool hasErrorsOnStart = false;
  bool hasErrorsOnEnd = false;

  @override
  void initState() {
    name.text = widget.model.name!;
    startLesson.text = widget.model.startLesson!;
    endLesson.text = widget.model.endLesson!;
    pause.text = widget.model.pause!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.0,
      children: [
        TextFormField(
          controller: name,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelText: 'Название (1 пара)',
              labelStyle: Theme.of(context).textTheme.headline3,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: startLesson,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          onChanged: (value) {
            setState(() {
              if (TimeTableLogic().validateToDate(startLesson.text)) {
                hasErrorsOnStart = false;
              } else {
                hasErrorsOnStart = true;
              }
            });
          },
          decoration: InputDecoration(
              errorText: hasErrorsOnStart ? 'Неправильно введено время' : null,
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Время начала пары (08:30)',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: endLesson,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          onChanged: (value) {
            setState(() {
              if (TimeTableLogic().validateToDate(endLesson.text)) {
                hasErrorsOnEnd = false;
              } else {
                hasErrorsOnEnd = true;
              }
            });
          },
          decoration: InputDecoration(
              errorText: hasErrorsOnEnd ? 'Неправильно введено время' : null,
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Время конца пары (10:00)',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: pause,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Перемена после пары (10 минут)',
              border: OutlineInputBorder(),
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
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () =>
                        TimeTableLogic().confirmDelete(context, widget.model),
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
                        if (!hasErrorsOnEnd &&
                            !hasErrorsOnStart &&
                            startLesson.text.isNotEmpty &&
                            endLesson.text.isNotEmpty) {
                          TimeTableLogic().editTimeTableItem(
                              widget.model.id!,
                              TimeModel(
                                name: name.text,
                                startLesson: startLesson.text,
                                endLesson: endLesson.text,
                                pause: pause.text,
                              ));
                          Navigator.pop(context);
                        }
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
