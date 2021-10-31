import 'package:flutter/material.dart';

import '/screens/settings/settings_logic.dart';
import '/utils/hive_helper.dart';
import 'announcements_logic.dart';
import 'announcements_ui.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  int tabLength() {
    if (SettingsLogic.doAccountHaveAccess(UserMode.admin)) {
      return 3;
    } else {
      if (SettingsLogic.isAccountModeLowLevel()) {
        return 1;
      } else {
        return 2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength(),
      child: Scaffold(
        body: TabBarView(
          children: [
            const AnnouncementsList(collectionPath: 'announcements_all'),
            if (SettingsLogic.doAccountHaveAccess(UserMode.employee))
              const AnnouncementsList(collectionPath: 'announcements_employee'),
            if (SettingsLogic.doAccountHaveAccess(UserMode.teacher))
              const AnnouncementsList(collectionPath: 'announcements_teachers')
          ],
        ),
        floatingActionButton: SettingsLogic.doAccountHaveAccess(UserMode.admin)
            ? FloatingActionButton(
                onPressed: () {
                  if (HiveHelper.getValue('username') == null) {
                    SettingsLogic.changeName(context);
                  } else {
                    AnnouncementsLogic().createNewAnnouncement(context);
                  }
                },
                child: const Icon(Icons.rate_review_outlined),
              )
            : null,
        bottomNavigationBar:
            SettingsLogic.isAccountModeLowLevel() ? null : const BottomTapBar(),
      ),
    );
  }
}
