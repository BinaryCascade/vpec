import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String text,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  Duration duration = const Duration(milliseconds: 4000),
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: behavior,
    duration: duration,
    content: Text(text),
  ));
}
