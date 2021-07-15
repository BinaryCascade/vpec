import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';

import 'view_document_logic.dart';

class DocumentViewer extends StatelessWidget {
  const DocumentViewer({Key? key, required this.isPDF, required this.url})
      : super(key: key);
  final String? url;
  final bool isPDF;

  @override
  Widget build(BuildContext context) {
    return isPDF ? buildPDFViewer() : buildMDViewer();
  }

  Widget buildPDFViewer() {
    return Center(
      child: ColorFiltered(
        colorFilter: ViewDocumentLogic.documentColorFilter(),
        child: const PDF(swipeHorizontal: true)
            .fromUrl(url!, placeholder: (progress) => const LoadingIndicator()),
      ),
    );
  }

  Widget buildMDViewer() {
    return const Center(
      child: Text('MD Viewer'), // TODO: implement MD viewer
    );
  }
}
