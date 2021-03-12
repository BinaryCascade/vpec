import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:vpec/models/announcement_model.dart';
import 'package:vpec/ui/widgets/announcement_card.dart';

Widget buildAlerts(String streamName) {
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
