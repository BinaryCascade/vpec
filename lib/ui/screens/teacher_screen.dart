import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vpec/models/teacher_model.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';

import '../../ui/widgets/teacher_card.dart';
import '../../utils/theme_helper.dart';

class TeacherScreen extends StatelessWidget {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('teacher_list').snapshots();

  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Преподаватели'),
        brightness:
            ThemeHelper().isDarkMode() ? Brightness.dark : Brightness.light,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LoadingIndicator();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data.docs.map((document) {
                return TeacherCard(
                  teacher: TeacherModel.fromMap(document.data(), document.id),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
