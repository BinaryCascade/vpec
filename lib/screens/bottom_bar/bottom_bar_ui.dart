import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/utils/icons.dart';
import '../../theme.dart';
import '../../utils/theme_helper.dart';
import '../announcements/announcements_screen.dart';
import '../cabinets_map/cabinets_map_screen.dart';
import '../menu/menu_screen.dart';
import '../news/news_screen.dart';
import '../schedule/schedule_screen.dart';
import 'bottom_bar_logic.dart';

class PageStorageUI extends StatelessWidget {
  const PageStorageUI({
    Key? key,
  }) : super(key: key);

  // List of screens for navigation
  static List<Widget> pages = const [
    NewsScreenProvider(),
    AnnouncementsScreen(),
    ScheduleScreen(),
    CabinetsMapScreen(),
    MenuScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarLogic>(
      builder: (context, storage, child) => PageStorage(
        bucket: PageStorageBucket(),
        child: pages[storage.bottomBarIndex],
      ),
    );
  }
}

class BottomBarUI extends StatelessWidget {
  const BottomBarUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarLogic>(
      builder: (context, storage, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
        value: ThemeHelper.overlayStyleHelper(context.palette.levelTwoSurface),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.palette.levelTwoSurface,
            border: Border(
              top: BorderSide(
                color: context.palette.outsideBorderColor,
                width: 1.0,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: storage.bottomBarIndex,
            onDestinationSelected: (index) {
              storage.setIndex(index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(VpecIconPack.news_outline),
                selectedIcon: Icon(VpecIconPack.news),
                label: 'События',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_outlined),
                selectedIcon: Icon(Icons.notifications),
                label: 'Объявления',
              ),
              NavigationDestination(
                icon: Icon(Icons.schedule_outlined),
                selectedIcon: Icon(Icons.watch_later),
                label: 'Расписание',
              ),
              NavigationDestination(
                icon: Icon(Icons.layers_outlined),
                selectedIcon: Icon(Icons.layers),
                label: 'Карта',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_outlined),
                selectedIcon: Icon(Icons.menu),
                label: 'Меню',
              ),
            ],
          ),
        ),
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
