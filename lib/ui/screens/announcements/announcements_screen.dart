import 'package:flutter/material.dart';

import '../../../ui/screens/settings/settings_logic.dart';
import '../../../utils/hive_helper.dart';
import 'announcements_logic.dart';
import 'announcements_ui.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isEmployee = SettingsLogic().getAccountEmail().isNotEmpty;

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
            ? BottomTapBar()
            : null,
      ),
    );
  }
}

