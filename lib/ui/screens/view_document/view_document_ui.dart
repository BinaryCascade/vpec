import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:vpec/models/document_model.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';

import 'view_document_logic.dart';

class DocumentViewer extends StatelessWidget {
  const DocumentViewer({Key? key, required this.document})
      : super(key: key);
  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    return document.type == 'pdf' ? buildPDFViewer() : buildMDViewer();
  }

  Widget buildPDFViewer() {
    return Center(
      child: ColorFiltered(
        colorFilter: ViewDocumentLogic.documentColorFilter(),
        child: const PDF(swipeHorizontal: true)
            .fromUrl(document.url!, placeholder: (progress) => const LoadingIndicator()),
      ),
    );
  }

  Widget buildMDViewer() {
    return Center(
      child: Text(document.data!), // TODO: implement MD viewer
    );
  }
}
