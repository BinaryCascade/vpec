import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: name,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(
                labelText: 'Название пары', hintText: '1 пара'),
          ),
        ),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: startLesson,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.headline4,
                inputFormatters: [MaskedInputFormatter('00:00')],
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
                    errorText: hasErrorsOnStart ? 'Неверный формат' : null,
                    labelText: 'Начало пары',
                    hintText: '08:30'),
              ),
            ),
            Text(
              ' – ',
              style: Theme.of(context).textTheme.headline3,
            ),
            Flexible(
              child: TextFormField(
                controller: endLesson,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.headline4,
                inputFormatters: [MaskedInputFormatter('00:00')],
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
                    errorText: hasErrorsOnEnd ? 'Неверный формат' : null,
                    labelText: 'Конец пары',
                    hintText: '10:00'),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextFormField(
            controller: pause,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.headline3,
            decoration: const InputDecoration(
                labelText: 'Перемена после пары', hintText: '10 минут'),
          ),
        ),
        ButtonBar(
          children: [
            Wrap(
              spacing: 12,
              children: [
                TextButton(
                  onPressed: () =>
                      TimeTableLogic().confirmDelete(context, widget.model),
                  child: const Text('Удалить'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
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
                    child: const Text('Редактировать'))
              ],
            ),
          ],
        )
      ],
    );
  }
}
