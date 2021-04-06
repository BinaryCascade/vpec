import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

import '../../../models/announcement_model.dart';
import '../../../ui/widgets/announcement_card.dart';

// ListView with data from Firestore
Widget buildAnnouncementsList(String streamName) {
  ScrollController _semicircleController = ScrollController();
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection(streamName).snapshots();

  return Column(
    children: <Widget>[
      Expanded(
        child: StreamBuilder(
          stream: stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Произошла ошибка при получении данных, пожалуйста, '
                    'войдите в аккаунт',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            return DraggableScrollbar.semicircle(
              backgroundColor: Theme.of(context).primaryColor,
              child: ListView(
                controller: _semicircleController,
                children: snapshot.data.docs
                    .map((document) {
                      return AnnouncementCard(
                          announcement: AnnouncementModel.fromMap(
                              document.data(), document.id));
                    })
                    .toList()
                    .reversed
                    .toList(),
              ),
              controller: _semicircleController,
              labelConstraints:
                  BoxConstraints.tightFor(width: 80.0, height: 30.0),
            );
          },
        ),
      ),
    ],
  );
}
