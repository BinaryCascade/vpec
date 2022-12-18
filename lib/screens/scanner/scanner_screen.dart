import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';
import 'scanner_ui.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome(mode: ColoringMode.byCurrentTheme);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Отсканируйте QR для входа'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ScannerWidget(),
            ManualLoginPrompt(),
          ],
        ),
      ),
    );
  }
}
