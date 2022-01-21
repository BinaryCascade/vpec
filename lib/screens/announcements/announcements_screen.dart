import 'package:flutter/material.dart';

import '../../utils/firebase_auth.dart';
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
  int get tabLength {
    if (AccountDetails.hasAccessToLevel(AccessLevel.admin)) {
      return 3;
    } else {
      if (AccountDetails.isAccountLowLevelAccess) {
        return 1;
      } else {
        return 2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength,
      child: Scaffold(
        body: TabBarView(
          children: [
            const AnnouncementsList(collectionPath: 'announcements_all'),
            if (AccountDetails.hasAccessToLevel(AccessLevel.employee))
              const AnnouncementsList(collectionPath: 'announcements_employee'),
            if (AccountDetails.hasAccessToLevel(AccessLevel.teacher))
              const AnnouncementsList(collectionPath: 'announcements_teachers')
          ],
        ),
        floatingActionButton: AccountDetails.hasAccessToLevel(AccessLevel.admin)
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
            AccountDetails.isAccountLowLevelAccess ? null : const BottomTapBar(),
      ),
    );
  }
}
