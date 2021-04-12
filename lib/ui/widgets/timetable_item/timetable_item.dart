import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:vpec/models/time_model.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FDottedLine(
            height: 99,
            strokeWidth: 3,
            dottedLength: 3,
            space: 0.0,
            color: Theme.of(context).textTheme.bodyText1.color),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.timeModel.startLesson + '-' + widget.timeModel.endLesson,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
              Text(widget.timeModel.name,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).textTheme.bodyText1.color)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBreak() {
    return Row(
      children: [
        FDottedLine(
          height: 55,
          strokeWidth: 3,
          dottedLength: 3,
          space: 3.0,
          color: Theme.of(context).textTheme.bodyText1.color,
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
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
