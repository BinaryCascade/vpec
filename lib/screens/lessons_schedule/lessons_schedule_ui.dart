import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/theme_helper.dart';
import '/utils/utils.dart';
import '/widgets/loading_indicator.dart';
import 'lessons_schedule_logic.dart';

class LessonImage extends StatelessWidget {
  const LessonImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonsScheduleLogic>(
      builder: (context, storage, child) => CachedNetworkImage(
        imageUrl: storage.imgUrl,
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
        placeholder: (context, url) => const LoadingIndicator(),
        imageBuilder: (context, imageProvider) => GestureDetector(
          onDoubleTapDown: storage.handleDoubleTapDown,
          onDoubleTap: storage.handleDoubleTap,
          child: InteractiveViewer(
            minScale: 1.0,
            maxScale: 10.0,
            transformationController: storage.transformationController,
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
          ),
        ),
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
            mini: true,
            child: const Icon(Icons.share_outlined),
            onPressed: () =>
                shareFile(context.read<LessonsScheduleLogic>().imgUrl),
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: FloatingActionButton(
            mini: true,
            child: const Icon(Icons.today_outlined),
            onPressed: () =>
                context.read<LessonsScheduleLogic>().chooseDate(context),
          ),
        ),
        FloatingActionButton(
          child: Icon(
              context.watch<LessonsScheduleLogic>().showForToday
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.arrow_back_ios_rounded,
              size: 24),
          onPressed: () {
            // this FAB used for switch between schedule for today or tomorrow
            context.read<LessonsScheduleLogic>().showForToday =
                !context.read<LessonsScheduleLogic>().showForToday;
            context.read<LessonsScheduleLogic>().updateImgUrl();
          },
        ),
      ],
    );
  }
}
