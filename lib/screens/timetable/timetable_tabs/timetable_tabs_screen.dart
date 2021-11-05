import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/timetable/timetable_item/timetable_item_logic.dart';
import '/screens/timetable/timetable_screen.dart';
import '/utils/hive_helper.dart';
import 'timetable_tabs_ui.dart';

class TimeTableTabs extends StatelessWidget {
  const TimeTableTabs({Key? key}) : super(key: key);

  int get getIndex {
    String? path = HiveHelper.getValue('timetable_path');
    if (path == null) return 0;
    switch (path) {
      case 'time_schedule':
        return 0;
      case 'time_schedule_second':
        return 1;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: getIndex,
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: ['time_schedule', 'time_schedule_second']
              .map((path) => ChangeNotifierProvider(
                    create: (_) => TimeTableItemLogic(),
                    child: TimeTableScreen(collectionPath: path),
                  ))
              .toList(),
        ),
        bottomNavigationBar: const TimeTableTabsUI(),
      ),
    );
  }
}
