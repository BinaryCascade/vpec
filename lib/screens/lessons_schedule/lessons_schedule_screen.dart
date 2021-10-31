import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/holiday_helper.dart';
import '/utils/theme_helper.dart';
import '/widgets/snow_widget.dart';
import 'lessons_schedule_logic.dart';
import 'lessons_schedule_ui.dart';

class LessonsScheduleScreen extends StatefulWidget {
  const LessonsScheduleScreen({Key? key}) : super(key: key);

  @override
  _LessonsScheduleScreenState createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<LessonsScheduleLogic>().onInitState(this);
    super.initState();
  }

  @override
  void deactivate() {
    context.read<LessonsScheduleLogic>().onDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (HolidayHelper().isNewYear)
            SnowWidget(
              isRunning: true,
              totalSnow: 20,
              speed: 0.4,
              snowColor: ThemeHelper.isDarkMode
                  ? Colors.white
                  : const Color(0xFFD6D6D6),
            ),
          const LessonImage(),
        ],
      ),
      floatingActionButton: const FabMenu(),
    );
  }
}
