import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import '../../../models/time_model.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../../ui/widgets/timetable_item/timetable_item.dart';
import 'timetable_logic.dart';

class TimeTableListView extends StatelessWidget {
  const TimeTableListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('time_schedule')
          .orderBy('order', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) return const LoadingIndicator();
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return TimeTableItem(
              timeModel: TimeModel.fromMap(snapshot.data!.docs[index].data(),
                  snapshot.data!.docs[index].id),
              isLast: snapshot.data!.docs.length == index + 1,
            );
          },
        );
      },
    );
  }
}

class EditorModeButtons extends StatelessWidget {
  const EditorModeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      direction: Axis.vertical,
      children: [
        FloatingActionButton(
            child: const Icon(
              Icons.delete_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().deleteAllDocs()),
        FloatingActionButton(
            child: const Icon(
              Icons.refresh_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().resetTimeTable(context)),
        FloatingActionButton(
            child: const Icon(
              Icons.add_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().addTimeTable(context)),
      ],
    );
  }
}

class ResetTimeTableDialogUI extends StatefulWidget {
  const ResetTimeTableDialogUI({Key? key}) : super(key: key);

  @override
  _ResetTimeTableDialogUIState createState() => _ResetTimeTableDialogUIState();
}

class _ResetTimeTableDialogUIState extends State<ResetTimeTableDialogUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              spacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                Text(
                  'Большая перемена:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                OutlinedButton(
                    onPressed: () => context
                        .read<TimeTableLogic>()
                        .restoreFiles(context, true),
                    child: const Text('30 мин')),
                OutlinedButton(
                    onPressed: () => context
                        .read<TimeTableLogic>()
                        .restoreFiles(context, false),
                    child: const Text('40 мин'))
              ]),
        ],
      ),
    );
  }
}

class AddTimeTableItemDialogUI extends StatefulWidget {
  const AddTimeTableItemDialogUI({Key? key}) : super(key: key);

  @override
  _AddTimeTableItemDialogUIState createState() =>
      _AddTimeTableItemDialogUIState();
}

class _AddTimeTableItemDialogUIState extends State<AddTimeTableItemDialogUI> {
  TextEditingController name = TextEditingController();
  TextEditingController startLesson = TextEditingController();
  TextEditingController endLesson = TextEditingController();
  TextEditingController pause = TextEditingController();
  bool hasErrorsOnStart = false;
  bool hasErrorsOnEnd = false;

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
              labelText: 'Название пары',
              hintText: '1 пара',
              labelStyle: Theme.of(context).textTheme.headline3,
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: startLesson,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.headline3,
                inputFormatters: [
                  MaskedInputFormatter('00:00')
                ],
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
                    labelStyle: Theme.of(context).textTheme.headline3,
                    labelText: 'Начало пары',
                    hintText: '08:30',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor))),
              ),
            ),
            Text(' – ', style: Theme.of(context).textTheme.headline3,),
            Flexible(
              child: TextFormField(
                controller: endLesson,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.headline3,
                inputFormatters: [
                  MaskedInputFormatter('00:00')
                ],
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
                    labelStyle: Theme.of(context).textTheme.headline3,
                    labelText: 'Конец пары',
                    hintText: '10:00',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).accentColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor))),
              ),
            ),
          ],
        ),
        TextFormField(
          controller: pause,
          textInputAction: TextInputAction.done,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Перемена после пары',
              hintText: '10 минут',
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
                          TimeTableLogic().addNewTimeTableItem(TimeModel(
                            name: name.text,
                            startLesson: startLesson.text,
                            endLesson: endLesson.text,
                            pause: pause.text,
                          ));
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Добавить',
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
