import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import 'bottom_bar_ui.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BreakpointBuilder(builder: (context, breakpoint) {
      if (breakpoint.window < WindowSize.small) {
        // mobile view
        return const Scaffold(
          body: PageStorageUI(),
          bottomNavigationBar: BottomBarUI(),
        );
      } else {
        // tablet view
        return const Scaffold(body: BuildTabletUI());
      }
    });
  }
}
