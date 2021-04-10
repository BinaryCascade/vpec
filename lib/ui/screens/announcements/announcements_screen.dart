import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../ui/screens/settings/settings_logic.dart';
import '../../../utils/hive_helper.dart';
import '../../../utils/icons.dart';
import 'announcements_logic.dart';
import 'announcements_ui.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth user = FirebaseAuth.instance;
    bool isEmployee = user.currentUser.email != null;

    return DefaultTabController(
      length: isEmployee ? 2 : 1,
      child: Scaffold(
        body: isEmployee
            ? TabBarView(
                children: [
                  AnnouncementsList(collectionPath: 'alerts'),
                  AnnouncementsList(collectionPath: 'privateAlerts'),
                ],
              )
            : AnnouncementsList(collectionPath: 'alerts'),
        floatingActionButton: isEmployee
            ? FloatingActionButton(
                onPressed: () {
                  if (HiveHelper().getValue('username') == null){
                    SettingsLogic().changeName(context);
                  } else {
                    AnnouncementsLogic().createNewAnnouncement(context);
                  }
                },
                child: Icon(Icons.rate_review_outlined),
              )
            : null,
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
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Всем',
                              style: TextStyle(fontSize: 15),
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
                            VpecIconPack.account_cog_outline,
                            size: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Сотрудникам',
                              style: TextStyle(fontSize: 15),
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
}
