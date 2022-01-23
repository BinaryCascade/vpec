import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../models/schedule/schedule_item.dart';
import 'schedule_logic.dart';

class SchedulePanel extends StatefulWidget {
  const SchedulePanel({Key? key}) : super(key: key);

  @override
  State<SchedulePanel> createState() => _SchedulePanelState();
}

class _SchedulePanelState extends State<SchedulePanel> {
  @override
  void initState() {
    context.read<ScheduleLogicTest>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScheduleLogicTest logic = context.read<ScheduleLogicTest>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<ScheduleItem>.generate(logic.timetable.length, (index) {
        String lessonNum = index.toString();
        return ScheduleItem(
          model: ScheduleItemModel(
            lessonNumber: index,
            lessonBeginning: logic.timetable[lessonNum].split('-').first,
            lessonEnding: logic.timetable[lessonNum].split('-').last,
            lessonName: logic.schedule[lessonNum],
            pauseAfterLesson: '10',
          ),
        );
      }),
    );
  }
}

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
                '${model.lessonNumber} пара - ${model.lessonName}',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  letterSpacing: 0.15,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'До конца: вечность',
                style: TextStyle(
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
            'Перемена: ${model.pauseAfterLesson}',
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
          onPressed: () {},
        ),
        const SizedBox(
          height: 8,
        ),
        FloatingActionButton(
          tooltip: 'Расписание на завтра/сегодня',
          child: const Icon(Icons.arrow_forward_ios_outlined),
          heroTag: null,
          onPressed: () {},
        ),
      ],
    );
  }
}
