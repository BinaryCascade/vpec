import 'package:flutter/material.dart';

import '../../models/document_model.dart';
import '../widgets/styled_widgets.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;

  const DocumentCard({Key? key, required this.document}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StyledListTile(
        title: document.title,
        subtitle: document.subtitle,
        onTap: () => Navigator.pushNamed(context, '/view_document',
            arguments: document));
  }
}
