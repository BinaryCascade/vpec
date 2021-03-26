import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/news_screen.dart';
import 'package:vpec/ui/screens/timetable_screen.dart';
import 'package:vpec/utils/icons.dart';

import 'announcements/announcements_screen.dart';
import 'lessons_schedule_screen.dart';
import 'menu/menu_screen.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  int bottomBarIndex = 0;
  // this bool used for a one-time arguments check
  bool isFirstAction = true;

  // List of screens for navigation
  final List<Widget> pages = [
    NewsScreen(),
    AnnouncementsScreen(),
    TimeTableScreen(),
    LessonsScheduleScreen(),
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null && isFirstAction) {
      int givenIndex = ModalRoute.of(context).settings.arguments;
      setState(() {
        isFirstAction = false;
        bottomBarIndex = givenIndex;
      });
    }

    return Scaffold(
      body: PageStorage(
        child: pages[bottomBarIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: bottomBarIndex,
        onTap: (index) {
          setState(() {
            bottomBarIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(VEKiconPack.news),
              label: 'Новости'),
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: Icon(Icons.notifications_outlined),
              label: 'Объявления'),
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: Icon(Icons.schedule_outlined),
              label: 'Звонки'),
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: Icon(Icons.dashboard_outlined),
              label: 'Расписание'),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            label: 'Меню',
            icon: Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}
