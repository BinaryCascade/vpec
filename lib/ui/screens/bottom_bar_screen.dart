import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpec/ui/screens/timetable_test_screen.dart';
import 'package:vpec/ui/widgets/timetable_item/timetable_item_logic.dart';

import '../../ui/screens/news_screen.dart';
import '../../ui/screens/timetable_screen.dart';
import '../../utils/icons.dart';
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
    ChangeNotifierProvider(
        create: (_) => TimeTableItemLogic(),
        child: TimeTableTestScreen()), // TODO: change to AnnouncementsScreen()
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
              icon: const Icon(VpecIconPack.news_outline),
              activeIcon: const Icon(VpecIconPack.news),
              label: 'Новости'),
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(Icons.notifications_outlined),
              activeIcon: const Icon(Icons.notifications),
              label: 'Объявления'),
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(Icons.schedule_outlined),
              activeIcon: const Icon(Icons.watch_later),
              label: 'Звонки'),
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(Icons.dashboard_outlined),
              activeIcon: const Icon(Icons.dashboard),
              label: 'Расписание'),
          BottomNavigationBarItem(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: const Icon(Icons.menu_outlined),
            activeIcon: const Icon(Icons.menu),
            label: 'Меню',
          ),
        ],
      ),
    );
  }
}
