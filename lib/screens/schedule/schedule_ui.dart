import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../models/full_schedule.dart';
import '../../models/schedule/schedule_item.dart';
import '../../utils/routes/routes.dart';
import 'schedule_logic.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({Key? key, required this.model}) : super(key: key);
  final ScheduleItemModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0, top: 9.0, bottom: 15.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 3,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.lessonBeginning} - ${model.lessonEnding}',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 36.0,
                  letterSpacing: 0.15,
                ),
              ),
              Text(
                '${model.lessonNumber} пара ${model.lessonName}',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  letterSpacing: 0.15,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                model.timer ?? '',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  letterSpacing: 0.15,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 9.5, bottom: 9),
          decoration: BoxDecoration(
            border: RDottedLineBorder(
              // Меняй этой значение, чтобы дэши попали в расстояние нормально
              dottedLength: 3.5,
              dottedSpace: 3,
              left: BorderSide(
                  width: 3, color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          child: Text(
            model.pauseAfterLesson,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              letterSpacing: 0.15,
            ),
          ),
        ),
      ],
    );
  }
}

class SchedulePanel extends StatelessWidget {
  const SchedulePanel({
    Key? key,
    required this.fullSchedule,
  }) : super(key: key);
  final FullSchedule fullSchedule;

  @override
  Widget build(BuildContext context) {
    List<ScheduleItem> schedulePanel =
        List<ScheduleItem>.generate(fullSchedule.timetable.length, (index) {
      String lessonNum = index.toString();
      String lessonEnding = fullSchedule.timetable[lessonNum].split('-').last;
      String nextLessonBeginning() {
        String? time = fullSchedule.timetable[(index + 1).toString()];
        if (time == null) return lessonEnding;

        return time.split('-').first;
      }

      String lessonName() {
        String name = fullSchedule.schedule[lessonNum];
        if (name == '0') name = '';
        if (name.isNotEmpty) name = '- $name';
        return name;
      }

      bool shouldGiveTimers = fullSchedule.timers.isNotEmpty;

      return ScheduleItem(
        model: ScheduleItemModel(
          timer: shouldGiveTimers ? fullSchedule.timers[index] : null,
          lessonNumber: index,
          teachers: fullSchedule.teachers,
          lessonsFullNames: fullSchedule.fullLessonNames,
          lessonsShortNames: fullSchedule.shortLessonNames,
          lessonBeginning: fullSchedule.timetable[lessonNum].split('-').first,
          lessonEnding: fullSchedule.timetable[lessonNum].split('-').last,
          lessonName: lessonName(),
          pauseAfterLesson: ScheduleTime.calculatePauseAfterLesson(
              lessonEnding, nextLessonBeginning()),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: schedulePanel,
    );
  }
}

// DottedDecoration(
// strokeWidth: 3,
// linePosition: LinePosition.left,
// dash: const [3, 3],
// color: Colors.white,
// )

class FABPanel extends StatelessWidget {
  const FABPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          mini: true,
          tooltip: 'Полное расписание',
          child: const Icon(Icons.fullscreen_outlined),
          heroTag: null,
          onPressed: () =>
              Navigator.pushNamed(context, Routes.fullScheduleScreen),
        ),
        const SizedBox(
          height: 8,
        ),
        FloatingActionButton(
          tooltip: 'Расписание на завтра/сегодня',
          child: Icon(context.watch<ScheduleLogic>().showingForToday
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_outlined),
          heroTag: null,
          onPressed: () => context.read<ScheduleLogic>().toggleShowingLesson(),
        ),
      ],
    );
  }
}
