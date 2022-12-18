import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/models/announcement_model.dart';
import '/utils/icons.dart';
import '/widgets/loading_indicator.dart';
import '../../theme.dart';
import 'announcement_card.dart';

/// ListView with data from Firestore
class AnnouncementsList extends StatefulWidget {
  final String collectionPath;

  const AnnouncementsList({
    Key? key,
    required this.collectionPath,
  }) : super(key: key);

  @override
  State<AnnouncementsList> createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> {
  final ScrollController semicircleController = ScrollController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  @override
  void initState() {
    stream = FirebaseFirestore.instance
        .collection(widget.collectionPath)
        .orderBy('id', descending: true)
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: stream,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Произошла ошибка при получении данных\n${snapshot.error}',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData) return const LoadingIndicator();

              return Align(
                alignment: Alignment.topCenter,
                child: Scrollbar(
                  interactive: true,
                  controller: semicircleController,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: semicircleController,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return AnnouncementCard(
                          announcement: AnnouncementModel.fromMap(
                            snapshot.data!.docs[index].data(),
                            snapshot.data!.docs[index].id,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnnouncementsTabBar extends StatefulWidget {
  const AnnouncementsTabBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AnnouncementsTabBar> createState() => _AnnouncementsTabBarState();
}

class _AnnouncementsTabBarState extends State<AnnouncementsTabBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: Container(
        color: context.palette.levelTwoSurface,
        child: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          isScrollable: true,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.group_outlined,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Студентам',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    VpecIconPack.parents,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Родителям',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.school_outlined,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Преподавателям',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    VpecIconPack.account_cog_outline,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Администрации',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
