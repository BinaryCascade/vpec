import 'package:flutter/material.dart';
import 'package:vpec/models/document_model.dart';
import 'package:vpec/ui/widgets/styled_widgets.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;

  const DocumentCard({Key key, this.document}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StyledListTile(
        title: document.title ?? 'Не указано',
        subtitle: document.subtitle ?? 'Не указано',
        onTap: () {
          Navigator.pushNamed(context, '/view_document', arguments: document);
        });
  }
}
