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
      return breakpoint.window < WindowSize.small
          ? const Scaffold(
              body: PageStorageUI(),
              bottomNavigationBar: BottomBarUI(),
            )
          : const Scaffold(body: BuildTabletUI());
    });
  }
}
