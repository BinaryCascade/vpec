import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {required String text, SnackBarBehavior behavior = SnackBarBehavior.floating}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: behavior,
    content: Text(text),
  ));
}
