import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '/models/document_model.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/styled_widgets.dart';

class DocumentsList extends StatelessWidget {
  const DocumentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection('documents').snapshots();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (!snapshot.hasData) return const LoadingIndicator();

        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map((document) {
            return DocumentCard(
              document: DocumentModel.fromMap(document.data(), document.id),
            );
          }).toList(),
        );
      },
    );
  }
}

class DocumentCard extends StatelessWidget {
  final DocumentModel document;

  const DocumentCard({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StyledListTile(
      title: document.title,
      subtitle: document.subtitle,
      onTap: () {
        FirebaseAnalytics.instance.logEvent(name: 'document_opened', parameters: {
          'url': document.url,
          'title': document.title,
        });

        Navigator.pushNamed(
        context,
        '/view_document',
        arguments: document,
      );
      },
    );
  }
}
