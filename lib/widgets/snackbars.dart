import 'package:flutter/material.dart';

import '../utils/theme/theme.dart';

void showSnackBar(
  BuildContext context, {
  required String text,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  Duration duration = const Duration(milliseconds: 4000),
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: context.palette.levelTwoSurface,
    behavior: behavior,
    duration: duration,
    content: Text(text, style: Theme.of(context).textTheme.subtitle2),
  ));
}
