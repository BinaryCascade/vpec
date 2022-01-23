import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/schedule/schedule_item.dart';
import 'schedule_logic.dart';
import 'schedule_ui.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleLogicTest(),
      child: Consumer<ScheduleLogicTest>(
        builder: (context, logic, child) {
          return Scaffold(
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 40,
                  left: 40,
                  right: 20,
                ),
                children: [
                  const Text(
                    'Расписание на',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 0.15,
                    ),
                  ),
                  // SizedBox(height: 6),
                  GestureDetector(
                    onTap: () async => await logic.getData(),
                    child: const Text(
                      '21 сентября 2021',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const SchedulePanel(),
                ],
              ),
            ),
            floatingActionButton: const FABPanel(),
          );
        },
      ),
    );
  }
}

class SchedulePanel extends StatelessWidget {
  const SchedulePanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logic = context.read<ScheduleLogicTest>();

    return FutureBuilder<bool>(
        future: logic.getData(),
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return Center(
              child: LinearProgressIndicator(
                color: Theme.of(context).colorScheme.onBackground,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            );
          }

          List<ScheduleItem> schedulePanel =
              List<ScheduleItem>.generate(logic.timetable.length, (index) {
            String lessonNum = index.toString();
            return ScheduleItem(
              model: ScheduleItemModel(
                lessonNumber: index,
                lessonBeginning: logic.timetable[lessonNum].split('-').first,
                lessonEnding: logic.timetable[lessonNum].split('-').last,
                lessonName: logic.schedule[lessonNum],
                pauseAfterLesson: '10', //TODO: автоматический рассчёт перемены
              ),
            );
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: schedulePanel,
          );
        });
  }
}
