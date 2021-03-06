import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/announcements_screen.dart';
import 'package:vpec/ui/screens/lessons_schedule_screen.dart';
import 'package:vpec/ui/screens/menu_screen.dart';
import 'package:vpec/ui/screens/news_screen.dart';
import 'package:vpec/ui/screens/timetable_screen.dart';
import 'package:vpec/utils/icons.dart';

class BottomBarScreen extends StatefulWidget {
  static final routeName = '/home';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  int _bbarIndex = 0;

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
    return Scaffold(
      body: PageStorage(
        child: pages[_bbarIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _bbarIndex,
        onTap: (index) {
          setState(() {
            _bbarIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: Icon(VEKiconPack.news),
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
