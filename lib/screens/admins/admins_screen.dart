import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/models/admin_model.dart';
import '/utils/theme_helper.dart';
import '/widgets/loading_indicator.dart';
import '../../widgets/system_bar_cover.dart';
import 'admins_ui.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      FirebaseFirestore.instance.collection('administration_list').snapshots();

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorSystemChrome(mode: ColoringMode.byCurrentTheme);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SystemBarCover(
        height: MediaQuery.of(context).padding.bottom,
      ),
      appBar: AppBar(title: const Text('Администрация')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (!snapshot.hasData) return const LoadingIndicator();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
