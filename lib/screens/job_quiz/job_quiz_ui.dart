import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/theme/theme.dart';
import 'job_quiz_logic.dart';

class QuestionBlock extends StatelessWidget {
  const QuestionBlock({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AnswersBlock extends StatefulWidget {
  const AnswersBlock({
    Key? key,
    required this.firstAnswer,
    required this.secondAnswer,
    required this.thirdAnswer,
    required this.fourthAnswer,
  }) : super(key: key);

  final String firstAnswer, secondAnswer, thirdAnswer, fourthAnswer;

  @override
  State<AnswersBlock> createState() => _AnswersBlockState();
}

class _AnswersBlockState extends State<AnswersBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnswerListTile(
          title: widget.firstAnswer,
          value: 1,
          groupValue: context.read<JobQuizStorage>().selectedAnswer,
          onChanged: (newValue) {
            setState(() {
              context.read<JobQuizStorage>().setAnswer(newValue!);
            });
          },
        ),
        AnswerListTile(
          title: widget.secondAnswer,
          value: 2,
          groupValue: context.read<JobQuizStorage>().selectedAnswer,
          onChanged: (newValue) {
            setState(() {
              context.read<JobQuizStorage>().setAnswer(newValue!);
            });
          },
        ),
        AnswerListTile(
          title: widget.thirdAnswer,
          value: 3,
          groupValue: context.read<JobQuizStorage>().selectedAnswer,
          onChanged: (newValue) {
            setState(() {
              context.read<JobQuizStorage>().setAnswer(newValue!);
            });
          },
        ),
        AnswerListTile(
          title: widget.fourthAnswer,
          value: 4,
          groupValue: context.read<JobQuizStorage>().selectedAnswer,
          onChanged: (newValue) {
            setState(() {
              context.read<JobQuizStorage>().setAnswer(newValue!);
            });
          },
        ),
      ],
    );
  }
}

class JobQuizFAB extends StatelessWidget {
  const JobQuizFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool needShowResult = context.select((JobQuizStorage storage) => storage.showResults);

    return needShowResult
        ? Container()
        : FloatingActionButton.extended(
            label: const Text('ВЫБРАТЬ'),
            icon: const Icon(Icons.check_outlined),
            onPressed: () {
              if (context.read<JobQuizStorage>().selectedAnswer == 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Выберите вариант ответа'),
                  behavior: SnackBarBehavior.floating,
                ));
              } else {
                context.read<JobQuizStorage>().chooseAnswer();
              }
            },
          );
  }
}

class JobQuizResults extends StatefulWidget {
  const JobQuizResults({Key? key}) : super(key: key);

  @override
  State<JobQuizResults> createState() => _JobQuizResultsState();
}

class _JobQuizResultsState extends State<JobQuizResults> {

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(name: 'job_quiz_completed');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            children: [
              ListTile(
                title: Text(
                  'Результаты теста',
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  context.read<JobQuizStorage>().resultText,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              ButtonBar(
                children: [
                  IconButton(
                    tooltip: 'Поделиться результатом',
                    onPressed: () {
                      FirebaseAnalytics.instance.logShare(
                        contentType: 'job_quiz_result',
                        itemId: context.read<JobQuizStorage>().resultText,
                        method: 'system_dialog',
                      );

                      Share.share(
                        context.read<JobQuizStorage>().resultText,
                      );
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      color: context.palette.accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerListTile extends StatelessWidget {
  final String? title;
  final int? value, groupValue;
  final void Function(int?)? onChanged;

  const AnswerListTile({
    Key? key,
    this.title,
    this.value,
    this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int?>(
      title: Text(
        title!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      activeColor: context.palette.accentColor,
      controlAffinity: ListTileControlAffinity.trailing,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
