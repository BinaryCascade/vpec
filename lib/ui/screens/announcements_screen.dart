import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vpec/models/announcement_model.dart';
import 'package:vpec/ui/widgets/announcement_card.dart';
import 'package:vpec/utils/icons.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  ScrollController _semicircleController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('alerts');
    Stream<QuerySnapshot> publicStream;
    publicStream = collectionReference.snapshots();

    CollectionReference collectionPrivateReference =
        FirebaseFirestore.instance.collection('privateAlerts');
    Stream<QuerySnapshot> privateStream;
    privateStream = collectionPrivateReference.snapshots();

    FirebaseAuth user = FirebaseAuth.instance;
    bool isEmployee = user.currentUser.email != null;

    return DefaultTabController(
      length: isEmployee ? 2 : 1,
      child: Scaffold(
        body: isEmployee
            ? TabBarView(
                children: [
                  _buildAlerts(publicStream),
                  _buildAlerts(privateStream),
                ],
              )
            : _buildAlerts(publicStream),
        bottomNavigationBar: isEmployee
            ? Container(
                height: kToolbarHeight,
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 3.0,
                    ),
                    insets: EdgeInsets.only(bottom: kToolbarHeight - 4),
                  ),
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Всем',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            VEKiconPack.account_cog_outline,
                            size: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Сотрудникам',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildAlerts(Stream<QuerySnapshot> stream) {
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
                            announcement: Announcement.fromMap(
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
}
