import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/full_schedule.dart';
import '../../models/schedule/schedule_item.dart';
import 'schedule_logic.dart';
import 'schedule_ui.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScheduleLogic(),
      builder: (_, __) => const ScheduleScreenUI(),
    );
  }
}

class ScheduleScreenUI extends StatefulWidget {
  const ScheduleScreenUI({Key? key}) : super(key: key);

  @override
  State<ScheduleScreenUI> createState() => _ScheduleScreenUIState();
}

class _ScheduleScreenUIState extends State<ScheduleScreenUI> {
  @override
  void initState() {
    context.read<ScheduleLogic>().showLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleLogic>(
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
                  onTap: () async => await logic.chooseData(context),
                  child: Text(
                    logic.printCurrentDate,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 36.0,
                      letterSpacing: 0.15,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                logic.fullSchedule == null
                    ? Center(
                        child: LinearProgressIndicator(
                          color: Theme.of(context).colorScheme.onBackground,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                      )
                    : SchedulePanel(
                        fullSchedule:
                            context.read<ScheduleLogic>().fullSchedule!),
              ],
            ),
          ),
          floatingActionButton: const FABPanel(),
        );
      },
    );
  }
}
