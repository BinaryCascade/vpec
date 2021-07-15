import 'package:flutter/material.dart';

import '../../../models/document_model.dart';
import '../../../utils/share_file.dart';
import '../../../utils/theme_helper.dart';
import 'view_document_ui.dart';

class DocumentViewScreen extends StatelessWidget {
  const DocumentViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DocumentModel doc;
    if (ModalRoute.of(context)!.settings.arguments is DocumentModel) {
      doc = ModalRoute.of(context)!.settings.arguments as DocumentModel;
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(doc.title),
        actions: [
          if (doc.type == 'pdf')
            IconButton(
                tooltip: 'Поделиться',
                onPressed: () => shareFile(doc.url),
                icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: DocumentViewer(url: doc.url, isPDF: doc.type == 'pdf'),
    );
  }
}
