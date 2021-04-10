import 'package:flutter/material.dart';

void showSnackbar(BuildContext context,
    {String text, SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: behavior,
    content: Text(text),
  ));
}
