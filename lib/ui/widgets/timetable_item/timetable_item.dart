import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/time_model.dart';
import 'timetable_item_logic.dart';

class TimeTableItem extends StatefulWidget {
  final TimeModel timeModel;

  const TimeTableItem({Key key, this.timeModel}) : super(key: key);

  @override
  _TimeTableItemState createState() => _TimeTableItemState();
}

class _TimeTableItemState extends State<TimeTableItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Wrap(
          direction: Axis.vertical,
          children: [
            buildLesson(),
            buildBreak(),
          ],
        ));
  }

  Widget buildLesson() {
    Color itemColor = context
            .read<TimeTableItemLogic>()
            .updateTimeItem(widget.timeModel)
            .isEmpty
        ? Theme.of(context).textTheme.subtitle1.color
        : Theme.of(context).textTheme.bodyText1.color;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDottedLine(
            height: 99,
            strokeWidth: 3,
            dottedLength: 3,
            space: 0.0,
            color: itemColor),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.timeModel.startLesson + '-' + widget.timeModel.endLesson,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: itemColor),
              ),
              Text(widget.timeModel.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: itemColor)),
              Text(
                  context
                      .watch<TimeTableItemLogic>()
                      .updateTimeItem(widget.timeModel),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: itemColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBreak() {
    Color itemColor = context
            .read<TimeTableItemLogic>()
            .updateTimeItem(widget.timeModel)
            .isEmpty
        ? Theme.of(context).textTheme.subtitle1.color
        : Theme.of(context).textTheme.bodyText1.color;

    return Row(
      children: [
        FDottedLine(
          height: 55,
          strokeWidth: 3,
          dottedLength: 3,
          space: 3.0,
          color: itemColor,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.timeModel.isLast
                    ? ""
                    : 'Перемена: ${widget.timeModel.pause}',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: itemColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
