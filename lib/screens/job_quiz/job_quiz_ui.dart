import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'job_quiz_logic.dart';

class QuestionBlock extends StatelessWidget {
  const QuestionBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Text(
        context.read<JobQuizStorage>().questionText,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AnswersBlock extends StatefulWidget {
  const AnswersBlock({Key? key}) : super(key: key);

  @override
  _AnswersBlockState createState() => _AnswersBlockState();
}

class _AnswersBlockState extends State<AnswersBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnswerListTile(
            title: context.read<JobQuizStorage>().firstAnswer,
            value: 1,
            groupValue: context.read<JobQuizStorage>().selectedAnswer,
            onChanged: (newValue) {
              setState(() {
                context.read<JobQuizStorage>().setAnswer(newValue!);
              });
            }),
        AnswerListTile(
            title: context.read<JobQuizStorage>().secondAnswer,
            value: 2,
            groupValue: context.read<JobQuizStorage>().selectedAnswer,
            onChanged: (newValue) {
              setState(() {
                context.read<JobQuizStorage>().setAnswer(newValue!);
              });
            }),
        AnswerListTile(
            title: context.read<JobQuizStorage>().thirdAnswer,
            value: 3,
            groupValue: context.read<JobQuizStorage>().selectedAnswer,
            onChanged: (newValue) {
              setState(() {
                context.read<JobQuizStorage>().setAnswer(newValue!);
              });
            }),
        AnswerListTile(
            title: context.read<JobQuizStorage>().fourthAnswer,
            value: 4,
            groupValue: context.read<JobQuizStorage>().selectedAnswer,
            onChanged: (newValue) {
              setState(() {
                context.read<JobQuizStorage>().setAnswer(newValue!);
              });
            }),
      ],
    );
  }
}

class JobQuizFAB extends StatelessWidget {
  const JobQuizFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool needShowResult =
        context.select((JobQuizStorage storage) => storage.showResults);
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

class JobQuizResults extends StatelessWidget {
  const JobQuizResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                  )),
              ButtonBar(
                children: [
                  IconButton(
                      tooltip: 'Поделиться результатом',
                      onPressed: () {
                        Share.share(
                          context.read<JobQuizStorage>().resultText,
                        );
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ))
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

  const AnswerListTile(
      {Key? key,
      this.title,
      this.value,
      this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int?>(
        title: Text(
          title!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        activeColor: Theme.of(context).colorScheme.secondary,
        controlAffinity: ListTileControlAffinity.trailing,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged);
  }
}
