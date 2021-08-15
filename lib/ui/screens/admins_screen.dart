import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/admin_model.dart';
import '../../ui/widgets/admin_card.dart';
import '../../utils/theme_helper.dart';
import '../widgets/loading_indicator.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      FirebaseFirestore.instance.collection('administration_list').snapshots();

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Администрация'),
        brightness:
            ThemeHelper.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) return const LoadingIndicator();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((document) {
                return AdminCard(
                  admin: AdminModel.fromMap(document.data(), document.id),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
