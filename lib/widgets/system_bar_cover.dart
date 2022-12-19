import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import '../utils/theme_helper.dart';

/// Used to cover content under system status bar with semi-transparent fill.
///
/// Used as [appBar] in [Scaffold].
/// Requires height of status bar -
/// usually [MediaQuery.of(context).padding.top].
/// Also requires [extendBodyBehindAppBar] in [Scaffold] to be set to true.
class StatusBarCover extends StatelessWidget implements PreferredSizeWidget {
  const StatusBarCover({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ColoredBox(
        color: context.palette.backgroundSurface.withOpacity(0.8),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

/// Used to cover content under system navigation bar with semi-transparent fill.
///
/// Used as [bottomNavigationBar] in [Scaffold].
/// Requires height of system navigation bar -
/// usually [MediaQuery.of(context).padding.bottom].
/// Also requires [extendBody] in [Scaffold] to be set to true.
class SystemNavBarCover extends StatelessWidget {
  const SystemNavBarCover({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ThemeHelper.overlayStyleHelper(context.palette.backgroundSurface),
      child: Padding(
        // ensures that cover is rendered - otherwise AnnotatedRegion will break
        padding: const EdgeInsets.only(top: 1.0),
        child: SizedBox(
          height: height,
          child: ColoredBox(
            color: context.palette.backgroundSurface.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
