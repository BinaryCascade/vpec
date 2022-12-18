import 'package:flutter/material.dart';

import '../theme.dart';

/// Used to cover content under system bars with semi-transparent fill.
///
/// Used as [appBar] or [bottomNavigationBar] in [Scaffold].
/// Requires height of system bar - usually either
/// [MediaQuery.of(context).padding.top] or [MediaQuery.of(context).padding.bottom].
/// Also requires [extendBodyBehindAppBar] and/or [extendBody] in [Scaffold] to be set to true.
class SystemBarCover extends StatelessWidget implements PreferredSizeWidget {
  const SystemBarCover({Key? key, required this.height}) : super(key: key);
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
