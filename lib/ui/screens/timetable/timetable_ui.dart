import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return LoadingIndicator();
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
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
            child: Icon(
              Icons.refresh_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().resetTimeTable(context)),
        FloatingActionButton(
            child: Icon(
              Icons.add_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().addTimeTable(context)),
      ],
    );
  }
}

class ResetTimeTableDialogUI extends StatefulWidget {
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
                        .startRestoringTimeSchedule(true),
                    child: Text('30 мин')),
                OutlinedButton(
                    onPressed: () => context
                        .read<TimeTableLogic>()
                        .startRestoringTimeSchedule(false),
                    child: Text('40 мин'))
              ]),
        ],
      ),
    );
  }
}
