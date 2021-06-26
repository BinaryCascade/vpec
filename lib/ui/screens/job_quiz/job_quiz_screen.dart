import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_helper.dart';
import 'job_quiz_logic.dart';
import 'job_quiz_ui.dart';

class JobQuizScreen extends StatefulWidget {
  const JobQuizScreen({Key? key}) : super(key: key);

  @override
  _JobQuizScreenState createState() => _JobQuizScreenState();
}

class _JobQuizScreenState extends State<JobQuizScreen> {

  @override
  Widget build(BuildContext context) {
    ThemeHelper.colorStatusBar(context: context, haveAppbar: true);

    return ChangeNotifierProvider(
      create: (_) => JobQuizStorage(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Проф. направленность'),
          brightness:
              ThemeHelper.isDarkMode() ? Brightness.dark : Brightness.light,
        ),
        body: Consumer<JobQuizStorage>(
          builder: (context, storage, child) {
            return storage.showResults
                ? const JobQuizResults()
                : Column(
                    children: const <Widget>[
                      QuestionBlock(),
                      AnswersBlock(),
                    ],
                  );
          },
        ),
        floatingActionButton: const JobQuizFAB(),
      ),
    );
  }
}
