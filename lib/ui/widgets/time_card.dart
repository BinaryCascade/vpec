import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vpec/models/time_model.dart';

class TimeScheduleCard extends StatefulWidget {
  final TimeModel time;

  TimeScheduleCard({@required this.time});

  @override
  _TimeScheduleCardState createState() => _TimeScheduleCardState();
}

class _TimeScheduleCardState extends State<TimeScheduleCard> {
  var settings = Hive.box('settings');
  var isLastTime;
  bool isNowBeforeWidgetTimeStart;
  bool isNowBeforeWidgetTimeEnd;
  Duration timeUntilLessonStart;
  Duration timeUntilLessonEnd;

  String timeText() {
    if (isNowBeforeWidgetTimeStart && isLastTime) {
      settings.put('isLastTime', false);
      return printStart();
    } else {
      if (isNowBeforeWidgetTimeEnd && isLastTime) {
        settings.put('isLastTime', false);
        return printEnd();
      } else {
        return '';
      }
    }
  }

  @override
  void initState() {
    isLastTime = settings.get('isLastTime');
    isNowBeforeWidgetTimeStart = DateTime.now().isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateFormat('HH:mm').parse(widget.time.startLesson).hour,
      DateFormat('HH:mm').parse(widget.time.startLesson).minute,
    ));
    isNowBeforeWidgetTimeEnd = DateTime.now().isBefore(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateFormat('HH:mm').parse(widget.time.endLesson).hour,
      DateFormat('HH:mm').parse(widget.time.endLesson).minute,
    ));
    timeUntilLessonStart = Duration(
        milliseconds: Jiffy(widget.time.startLesson, "HH:mm")
            .diff(Jiffy(Jiffy().Hm, "HH:m"), Units.MILLISECOND));
    timeUntilLessonEnd = Duration(
        milliseconds: Jiffy(widget.time.endLesson, "HH:mm")
            .diff(Jiffy(Jiffy().Hm, "HH:m"), Units.MILLISECOND));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLastTime = settings.get('isLastTime');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Column(
            children: [
              FDottedLine(
                height: 99,
                strokeWidth: 3,
                dottedLength: 3,
                space: 0.0,
                color: timeText().isEmpty
                    ? Theme.of(context).textTheme.subtitle1.color
                    : Theme.of(context).textTheme.bodyText1.color,
              ),
              FDottedLine(
                height: 55,
                strokeWidth: 3,
                dottedLength: 3,
                space: 3.0,
                color: timeText().isEmpty
                    ? Theme.of(context).textTheme.subtitle1.color
                    : Theme.of(context).textTheme.bodyText1.color,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.time.startLesson + '-' + widget.time.endLesson,
                style: timeText().isEmpty
                    ? Theme.of(context).textTheme.headline5.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .headline5
                        .color
                        .withOpacity(0.60))
                    : Theme.of(context).textTheme.headline5.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
              Text(widget.time.name,
                  style: timeText().isEmpty
                      ? Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.60))
                      : Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).textTheme.bodyText1.color)),
              Text(
                timeText(),
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  widget.time.isLast ? "" : 'Перемена: ${widget.time.pause}',
                  style: timeText().isEmpty
                      ? Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .headline6
                          .color
                          .withOpacity(0.60))
                      : Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String printStart() {
    return 'До начала: ' +
        prettyDuration(timeUntilLessonStart,
            locale: DurationLocale.fromLanguageCode('ru'));
  }

  String printEnd() {
    var hourText = DateFormat('HH:mm')
        .parse(timeUntilLessonEnd.toString().replaceAll(":00.000000", ''))
        .hour
        .toString() +
        ' ч. ';
    return 'До конца: ' +
        hourText.replaceAll("0 ч.", "") +
        DateFormat('HH:mm')
            .parse(timeUntilLessonEnd.toString().replaceAll(":00.000000", ''))
            .minute
            .toString() +
        ' мин.';
  }
}