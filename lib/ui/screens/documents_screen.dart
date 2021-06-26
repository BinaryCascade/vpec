import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';
import 'menu/menu_ui.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Документы'),
      ),
      body: Column(
        children: const <Widget>[
          ViewDocuments(),
        ],
      ),
    );
  }
}
