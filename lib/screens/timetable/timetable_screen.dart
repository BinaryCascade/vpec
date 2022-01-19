import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/hive_helper.dart';
import '/utils/holiday_helper.dart';
import '/utils/theme_helper.dart';
import '/widgets/snow_widget.dart';
import '../../utils/firebase_auth.dart';
import 'timetable_item/timetable_item_logic.dart';
import 'timetable_ui.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({
    Key? key,
    required this.collectionPath,
  }) : super(key: key);
  final String collectionPath;

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  @override
  void initState() {
    context.read<TimeTableItemLogic>().cancelTimer();
    context.read<TimeTableItemLogic>().updateTime();
    HiveHelper.saveValue(key: 'timetable_path', value: widget.collectionPath);
    super.initState();
  }

  @override
  void deactivate() {
    context.read<TimeTableItemLogic>().cancelTimer();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        if (HolidayHelper.isNewYear)
          SnowWidget(
            isRunning: true,
            totalSnow: 20,
            speed: 0.4,
            snowColor:
                ThemeHelper.isDarkMode ? Colors.white : const Color(0xFFD6D6D6),
          ),
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 30),
            child: TimeTableListView(
              collectionPath: widget.collectionPath,
            ),
          ),
        ),
      ]),
      floatingActionButton: AccountEditorMode().isEditorModeActive
          ? const EditorModeButtons()
          : null,
    );
  }
}
