import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/document_model.dart';
import '../../../ui/widgets/document_card.dart';
import '../../widgets/loading_indicator.dart';

class ViewDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection('documents').snapshots();
    return Flexible(
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return LoadingIndicator();
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: snapshot.data!.docs.map((document) {
              return DocumentCard(
                document: DocumentModel.fromMap(document.data(), document.id),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
