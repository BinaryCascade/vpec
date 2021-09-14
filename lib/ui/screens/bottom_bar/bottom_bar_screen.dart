import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../announcements/announcements_screen.dart';
import '../lessons_schedule/lessons_schedule_logic.dart';
import '../lessons_schedule/lessons_schedule_screen.dart';
import '../menu/menu_screen.dart';
import '../news/news_screen.dart';
import '../timetable_tabs/timetable_tabs_screen.dart';
import 'bottom_bar_ui.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List of screens for navigation
  final List<Widget> pages = [
    const NewsScreenProvider(),
    const AnnouncementsScreen(),
    const TimeTableTabs(),
    ChangeNotifierProvider(
        create: (_) => LessonsScheduleLogic(),
        child: const LessonsScheduleScreen()),
    const MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorageUI(pages: pages),
      bottomNavigationBar: const BottomBarUI(),
    );
  }
}
