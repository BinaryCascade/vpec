import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String text,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  Duration duration = const Duration(milliseconds: 4000),
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    behavior: behavior,
    duration: duration,
    content: Text(text, style: Theme.of(context).textTheme.subtitle2),
  ));
}
