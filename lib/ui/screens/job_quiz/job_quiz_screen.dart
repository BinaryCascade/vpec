import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'job_quiz_logic.dart';
import 'job_quiz_ui.dart';
import '../../../utils/theme_helper.dart';

class JobQuizScreen extends StatefulWidget {
  @override
  _JobQuizScreenState createState() => _JobQuizScreenState();
}

class _JobQuizScreenState extends State<JobQuizScreen> {
  JobQuizStorage storage = Get.put(JobQuizStorage());
  RxInt chlen = 1.obs;

  @override
  void dispose() {
    Get.reset();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Проф. направленность'),
        brightness:
            ThemeHelper().isDarkMode() ? Brightness.dark : Brightness.light,
      ),
      body: storage.showResults
          ? buildResults(context)
          : Column(
              children: [
                buildQuestion(context),
                buildAnswersBlock(context),
              ],
            ),
      floatingActionButton: buildFAB(context),
    );
  }
}
