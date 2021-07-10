import 'package:flutter/material.dart';

class StyledOutlinedButton extends StatelessWidget {
  const StyledOutlinedButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.width = double.infinity,
      this.height = 42.0,
      this.child})
      : super(key: key);

  final Widget? child;
  final String? text;
  final void Function()? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        child: child ?? Text(text ?? ''),
      ),
    );
  }
}
