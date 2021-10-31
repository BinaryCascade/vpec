import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/icons.dart';
import 'bottom_bar_logic.dart';

class PageStorageUI extends StatelessWidget {
  const PageStorageUI({
    Key? key,
    required this.pages,
  }) : super(key: key);

  final List<Widget> pages;

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
