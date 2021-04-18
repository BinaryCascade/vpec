import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/timetable_item/timetable_item_logic.dart';
import '../announcements/announcements_screen.dart';
import '../lessons_schedule/lessons_schedule_screen.dart';
import '../menu/menu_screen.dart';
import '../news_screen.dart';
import '../timetable_screen.dart';
import 'bottom_bar_ui.dart';
import '../lessons_schedule/lessons_schedule_logic.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List of screens for navigation
  final List<Widget> pages = [
    NewsScreen(),
    AnnouncementsScreen(),
    ChangeNotifierProvider(
        create: (_) => TimeTableItemLogic(), child: TimeTableScreen()),
    ChangeNotifierProvider(
        create: (_) => LessonsScheduleLogic(), child: LessonsScheduleScreen()),
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorageUI(pages: pages),
      bottomNavigationBar: BottomBarUI(),
    );
  }
}
