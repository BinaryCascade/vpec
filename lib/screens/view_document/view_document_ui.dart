import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:uc_pdfview/uc_pdfview.dart';

import '/models/document_model.dart';
import '/utils/utils.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/markdown_widget.dart';
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
        return buildPDFViewer();
      case 'md':
        return buildMDViewer();
      default:
        return buildError();
    }
  }

  Widget buildPDFViewer() {
    return Center(
      child: FutureBuilder<Uint8List>(
        initialData: null,
        future: ViewDocumentLogic.getPDFData(document.url),
        builder: (context, pdfData) {
          if (!pdfData.hasData) return const LoadingIndicator();

          return ColorFiltered(
            colorFilter: ViewDocumentLogic.documentColorFilter,
            child: UCPDFView(
              pdfData: pdfData.data,
            ),
          );
        },
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

  Widget buildError() {
    return Center(
      child: SelectableLinkify(
        text:
            'Неподдерживаемый тип файла: ${ViewDocumentLogic.getFileExtension(document.url)}\nИсходная ссылка:\n${document.url}',
        textAlign: TextAlign.center,
        onOpen: (link) => openUrl(link.url),
      ),
    );
  }
}
