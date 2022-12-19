import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';
import '../../widgets/system_bar_cover.dart';
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
      extendBody: true,
      bottomNavigationBar: SystemNavBarCover(
        height: MediaQuery.of(context).padding.bottom,
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
