import 'package:flutter/material.dart';

import '../../widgets/loading_indicator.dart';
import 'login_logic.dart';

class EntrantButton extends StatefulWidget {
  const EntrantButton({Key? key}) : super(key: key);

  @override
  State<EntrantButton> createState() => _EntrantButtonState();
}

class _EntrantButtonState extends State<EntrantButton> {
  // used to display the download state
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: LoadingIndicator(
                delayedAppears: false,
              ),
            )
          : const Text(
              'Я абитуриент',
              style: TextStyle(fontSize: 16),
            ),
      onPressed: () async {
        if (_isLoading) {
          // do nothing if already loading
          return;
        }

        _isLoading = true;
        (context as Element).markNeedsBuild();

        await LoginLogic.openEntrantScreen(context);

        _isLoading = false;
        context.markNeedsBuild();
      },
    );
  }
}
