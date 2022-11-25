import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../utils/firebase_auth.dart';
import '../../utils/theme_helper.dart';
import 'announcements_ui.dart';
import 'editor/editor_screen.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  List<Widget> get tabBarChildren {
    switch (AccountDetails.getAccountLevel) {
      case AccountType.admin:
        return [
          const AnnouncementsList(collectionPath: 'announcements_students'),
          const AnnouncementsList(collectionPath: 'announcements_parents'),
          const AnnouncementsList(collectionPath: 'announcements_teachers'),
        ];
      case AccountType.student:
        return [
          const AnnouncementsList(collectionPath: 'announcements_students'),
        ];
      case AccountType.parent:
        return [
          const AnnouncementsList(collectionPath: 'announcements_parents'),
        ];
      case AccountType.teacher:
        return [
          const AnnouncementsList(collectionPath: 'announcements_teachers'),
        ];
      default:
        return [
          const AnnouncementsList(collectionPath: 'announcements_students'),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarChildren.length,
      child: Scaffold(
        body: TabBarView(children: tabBarChildren),
        floatingActionButton:
            AccountDetails.isAdmin ? _buildFab(context) : null,
        bottomNavigationBar:
            AccountDetails.isAdmin ? const BottomTapBar() : null,
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return OpenContainer(
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      middleColor: Theme.of(context).scaffoldBackgroundColor,
      openColor: Theme.of(context).scaffoldBackgroundColor,
      onClosed: (n) {
        Future.delayed(const Duration(milliseconds: 100)).then((value) =>
            ThemeHelper.colorStatusBar(context: context, haveAppbar: false));
      },
      closedBuilder: (context, action) {
        return FloatingActionButton(
          onPressed: action,
          child: const Icon(Icons.rate_review_outlined),
        );
      },
      openBuilder: (context, action) {
        return const AnnouncementEditor();
      },
    );
  }
}
