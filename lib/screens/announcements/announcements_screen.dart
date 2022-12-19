import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../utils/firebase_auth.dart';
import '../../utils/theme/theme.dart';
import '../../utils/theme_helper.dart';
import '../../widgets/system_bar_cover.dart';
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
          const AnnouncementsList(collectionPath: 'announcements_admins'),
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
        extendBodyBehindAppBar: true,
        appBar: StatusBarCover(
          height: MediaQuery.of(context).padding.top,
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: tabBarChildren,
        ),
        floatingActionButton:
            AccountDetails.isAdmin ? const AnimatedFAB() : null,
        bottomNavigationBar:
            AccountDetails.isAdmin ? const AnnouncementsTabBar() : null,
      ),
    );
  }
}

class AnimatedFAB extends StatelessWidget {
  const AnimatedFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 600),
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      closedShape: CircleBorder(
        side: BorderSide(color: context.palette.outsideBorderColor),
      ),
      closedColor: context.palette.levelThreeSurface,
      middleColor: context.palette.backgroundSurface,
      openElevation: 0,
      openColor: context.palette.backgroundSurface,
      onClosed: (n) {
        Future.delayed(const Duration(milliseconds: 100)).then(
          (value) => ThemeHelper.colorSystemChrome(
            mode: ColoringMode.byCurrentTheme,
          ),
        );
      },
      closedBuilder: (context, action) {
        return FloatingActionButton(
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
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
