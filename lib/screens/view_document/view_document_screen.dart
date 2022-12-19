import 'package:flutter/material.dart';

import '/models/document_model.dart';
import '/utils/theme_helper.dart';
import '/utils/utils.dart';
import '../../widgets/system_bar_cover.dart';
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
    ThemeHelper.colorSystemChrome(mode: ColoringMode.byCurrentTheme);
    bool isFilePDF = ViewDocumentLogic.getFileExtension(document.url) == 'pdf';

    return Scaffold(
      // no extendBody due to documents being weird
      bottomNavigationBar: SystemNavBarCover(
        height: MediaQuery.of(context).padding.bottom,
      ),
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          if (isFilePDF)
            IconButton(
              tooltip: 'Поделиться',
              onPressed: () => shareFile(document.url),
              icon: const Icon(Icons.share_outlined),
            ),
          if (isFilePDF)
            IconButton(
              tooltip: 'Открыть в другом приложении',
              onPressed: () => openUrl(document.url),
              icon: const Icon(Icons.open_in_new_outlined),
            ),
        ],
      ),
      body: DocumentViewer(document: document),
    );
  }
}
