import 'package:flutter/material.dart';

class TimeTableTabsUI extends StatelessWidget {
  const TimeTableTabsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: Container(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: TabBar(
          isScrollable: false,
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
      ),
    );
  }
}
