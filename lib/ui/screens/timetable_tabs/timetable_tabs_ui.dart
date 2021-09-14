import 'package:flutter/material.dart';

class TimeTableTabsUI extends StatelessWidget {
  const TimeTableTabsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: TabBar(
        isScrollable: false,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 3.0,
          ),
          insets: const EdgeInsets.only(bottom: kToolbarHeight - 4),
        ),
        labelColor: Theme.of(context).colorScheme.secondary,
        unselectedLabelColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).colorScheme.secondary,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    '1-2 курс',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    '3-4 курс',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
