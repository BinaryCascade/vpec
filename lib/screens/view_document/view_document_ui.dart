import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '/ui/widgets/loading_indicator.dart';
import '/ui/widgets/markdown_widget.dart';
import '/utils/utils.dart';
import '../../../models/document_model.dart';
import 'view_document_logic.dart';

@immutable
class DocumentViewer extends StatelessWidget {
  const DocumentViewer({Key? key, required this.document}) : super(key: key);
  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    String docType = ViewDocumentLogic.getFileExtension(document.url);

    switch (docType) {
      case 'pdf':
        return buildLegacyPDFViewer();
      case 'md':
        return buildMDViewer();
      default:
        return buildError();
    }
  }

  Widget buildLegacyPDFViewer() {
    return Center(
      child: ColorFiltered(
        colorFilter: ViewDocumentLogic.documentColorFilter,
        child: const PDF(swipeHorizontal: true).fromUrl(document.url,
            placeholder: (progress) => const LoadingIndicator()),
      ),
    );
  }

  Widget buildPDFViewer() {
    return ColorFiltered(
      colorFilter: ViewDocumentLogic.documentColorFilter,
      child: SfPdfViewer.network(
        document.url,
        enableTextSelection: false,
        interactionMode: PdfInteractionMode.pan,
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: SelectableLinkify(
        text: 'Неподдерживаемый тип файла: ' +
            ViewDocumentLogic.getFileExtension(document.url) +
            '\nИсходная ссылка:\n${document.url}',
        textAlign: TextAlign.center,
        onOpen: (link) => openUrl(link.url),
      ),
    );
  }

  Widget buildMDViewer() {
    return Center(
      child: FutureBuilder<String>(
        future: ViewDocumentLogic.getMDText(document.url),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return const LoadingIndicator();
          return MarkdownWidget(data: snapshot.data!);
        },
      ),
    );
  }
}
