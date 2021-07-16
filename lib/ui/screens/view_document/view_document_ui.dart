import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:vpec/models/document_model.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';

import 'view_document_logic.dart';

class DocumentViewer extends StatelessWidget {
  const DocumentViewer({Key? key, required this.document}) : super(key: key);
  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    return document.type == 'pdf' ? buildPDFViewer() : buildMDViewer(context);
  }

  Widget buildPDFViewer() {
    return Center(
      child: ColorFiltered(
        colorFilter: ViewDocumentLogic.documentColorFilter(),
        child: const PDF(swipeHorizontal: true).fromUrl(document.url!,
            placeholder: (progress) => const LoadingIndicator()),
      ),
    );
  }

  Widget buildMDViewer(BuildContext context) {
    return Center(
      child: Markdown(
        data: document.data!.replaceAll('\\n', '\n'),
        styleSheet: MarkdownStyleSheet(
          h1: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 48,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5),
          h2: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 38,
              fontWeight: FontWeight.w400),
          h3: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: 'Montserrat',
              fontSize: 32,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25),
          h4: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.w500),
          h5: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15),
          h6: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2),
          p: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5
          ),
        ),
      ),
    );
  }
}
