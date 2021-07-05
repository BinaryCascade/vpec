import 'package:flutter/material.dart';

class StyledOutlinedButton extends StatelessWidget {
  const StyledOutlinedButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.width = double.infinity,
      this.height = 42.0})
      : super(key: key);

  final String text;
  final void Function()? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: Theme.of(context).outlinedButtonTheme.style,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
    );
  }
}
