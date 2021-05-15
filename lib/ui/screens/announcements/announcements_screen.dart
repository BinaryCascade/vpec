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
    UserMode userMode = SettingsLogic.getAccountMode();
    bool shouldShowMoreData =
        userMode != UserMode.student || userMode != UserMode.enrollee;

    return DefaultTabController(
      length: shouldShowMoreData ? 2 : 1,
      child: Scaffold(
        body: shouldShowMoreData
            ? TabBarView(
                children: [
                  AnnouncementsList(collectionPath: 'announcements_all'),
                  if (userMode == UserMode.admin ||
                      userMode == UserMode.employee)
                    AnnouncementsList(collectionPath: 'announcements_employee'),
                  if (userMode == UserMode.teacher ||
                      userMode == UserMode.admin)
                    AnnouncementsList(collectionPath: 'announcements_teachers')
                ],
              )
            : AnnouncementsList(collectionPath: 'alerts'),
        floatingActionButton: shouldShowMoreData
            ? FloatingActionButton(
                onPressed: () {
                  if (HiveHelper().getValue('username') == null) {
                    SettingsLogic().changeName(context);
                  } else {
                    AnnouncementsLogic().createNewAnnouncement(context);
                  }
                },
                child: Icon(Icons.rate_review_outlined),
              )
            : null,
        bottomNavigationBar: shouldShowMoreData ? BottomTapBar() : null,
      ),
    );
  }
}
