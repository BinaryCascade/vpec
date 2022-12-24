import 'package:flutter/material.dart';

import '/utils/theme_helper.dart';
import '../../widgets/system_bar_cover.dart';
import 'documents_ui.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome();

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SystemNavBarCover(
        height: MediaQuery.of(context).padding.bottom,
      ),
      appBar: AppBar(
        title: const Text('Документы'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const <Widget>[
            DocumentsList(),
          ],
        ),
      ),
    );
  }
}
