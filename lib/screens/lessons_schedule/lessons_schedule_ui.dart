import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/theme_helper.dart';
import '/utils/utils.dart';
import '/widgets/loading_indicator.dart';
import '../../widgets/interactive_widget.dart';
import 'lessons_schedule_logic.dart';

class LessonsScheduleViewer extends StatelessWidget {
  const LessonsScheduleViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonsScheduleLogic>(
      builder: (context, storage, child) => CachedNetworkImage(
        imageUrl: storage.imgUrl,
        placeholder: (context, url) => const LoadingIndicator(),
        errorWidget: (context, url, error) => Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              'Расписание на\n${storage.parseDateFromUrl}\nне найдено',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        imageBuilder: (context, imageProvider) {
          return InteractiveWidget(
            child: ColorFiltered(
              colorFilter: ThemeHelper.isDarkMode
                  ? const ColorFilter.matrix([
                      //R G  B  A  Const
                      -0.87843, 0, 0, 0, 255,
                      0, -0.87843, 0, 0, 255,
                      0, 0, -0.87843, 0, 255,
                      0, 0, 0, 1, 0,
                    ])
                  : const ColorFilter.matrix([
                      //R G  B  A  Const
                      0.96078, 0, 0, 0, 0,
                      0, 0.96078, 0, 0, 0,
                      0, 0, 0.96078, 0, 0,
                      0, 0, 0, 1, 0,
                    ]),
              child: Center(
                child: Image(
                  image: imageProvider,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FabMenu extends StatelessWidget {
  const FabMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (!kIsWeb)
          FloatingActionButton(
            heroTag: null,
            mini: true,
            child: const Icon(Icons.share_outlined),
            onPressed: () => shareFile(context.read<LessonsScheduleLogic>().imgUrl),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: FloatingActionButton(
            heroTag: null,
            mini: true,
            child: const Icon(Icons.today_outlined),
            onPressed: () => context.read<LessonsScheduleLogic>().chooseDate(context),
          ),
        ),
        FloatingActionButton(
          heroTag: null,
          child: Icon(
            context.watch<LessonsScheduleLogic>().showForToday
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_rounded,
            size: 24,
          ),
          onPressed: () {
            LessonsScheduleLogic logic = context.read<LessonsScheduleLogic>();
            // this FAB used for switch between schedule for today or tomorrow
            logic.showForToday = !logic.showForToday;
            logic.updateImgUrl();

            FirebaseAnalytics.instance.logEvent(name: 'full_schedule_today_fab', parameters: {
              'today': logic.showForToday,
            });
          },
        ),
      ],
    );
  }
}
