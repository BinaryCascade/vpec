import 'package:flutter/material.dart';

import '../../../models/document_model.dart';
import '../../../utils/theme_helper.dart';
import '../../../utils/utils.dart';
import 'view_document_logic.dart';
import 'view_document_ui.dart';

@immutable
class DocumentViewScreen extends StatelessWidget {
  const DocumentViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DocumentModel document;
    if (ModalRoute.of(context)!.settings.arguments is DocumentModel) {
      document = ModalRoute.of(context)!.settings.arguments as DocumentModel;
    } else {
      Navigator.popAndPushNamed(context, '/');
    }
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          if (ViewDocumentLogic.getFileExtension(document.url) == 'pdf')
            IconButton(
                tooltip: 'Поделиться',
                onPressed: () => shareFile(document.url),
                icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: DocumentViewer(document: document),
    );
  }
}
