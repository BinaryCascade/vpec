import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/icons.dart';
import '../announcements/announcements_screen.dart';
import '../lessons_schedule/lessons_schedule_logic.dart';
import '../lessons_schedule/lessons_schedule_screen.dart';
import '../menu/menu_screen.dart';
import '../news/news_screen.dart';
import '../timetable/timetable_tabs/timetable_tabs_screen.dart';
import 'bottom_bar_logic.dart';

class PageStorageUI extends StatelessWidget {
  const PageStorageUI({
    Key? key,
  }) : super(key: key);

  // List of screens for navigation
  static List<Widget> pages = [
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
    return Consumer<BottomBarLogic>(
      builder: (context, storage, child) => PageStorage(
        child: pages[storage.bottomBarIndex],
        bucket: PageStorageBucket(),
      ),
    );
  }
}

class BottomBarUI extends StatelessWidget {
  const BottomBarUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarLogic>(
      builder: (context, storage, child) => BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: storage.bottomBarIndex,
        onTap: (index) {
          storage.setIndex(index);
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              icon: const Icon(VpecIconPack.news_outline),
              activeIcon: const Icon(VpecIconPack.news),
              label: 'События'),
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

class BuildTabletUI extends StatelessWidget {
  const BuildTabletUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarLogic>(
      child: const Expanded(
        child: PageStorageUI(),
      ),
      builder: (context, storage, child) => Row(
        children: [
          NavigationRail(
            groupAlignment: -0.9,
            selectedIndex: storage.bottomBarIndex,
            labelType: NavigationRailLabelType.none,
            onDestinationSelected: (value) => storage.setIndex(value),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(VpecIconPack.news_outline),
                selectedIcon: Icon(VpecIconPack.news),
                label: Text('События'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications_outlined),
                selectedIcon: Icon(Icons.notifications),
                label: Text('Объявления'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.schedule_outlined),
                selectedIcon: Icon(Icons.watch_later),
                label: Text('Звонки'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Расписание'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.menu_outlined),
                selectedIcon: Icon(Icons.menu),
                label: Text('Меню'),
              ),
            ],
          ),
          child!,
        ],
      ),
    );
  }
}
