import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'job_quiz_logic.dart';

Widget buildQuestion(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(13.0),
    child: Text(
      questionText(),
      style: Theme.of(context).textTheme.headline4,
      textAlign: TextAlign.center,
    ),
  );
}

Widget buildAnswersBlock(BuildContext context) {
  JobQuizStorage storage = Get.put(JobQuizStorage());

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return Column(
        children: [
          answerListTile(
              context: context,
              title: storage.firstAnswer(),
              value: 1,
              groupValue: storage.selectedAnswer,
              onChanged: (num) {
                setState(() {
                  storage.selectedAnswer = num;
                });
              }),
          answerListTile(
              context: context,
              title: storage.secondAnswer(),
              value: 2,
              groupValue: storage.selectedAnswer,
              onChanged: (num) {
                setState(() {
                  storage.selectedAnswer = num;
                });
              }),
          answerListTile(
              context: context,
              title: storage.thirdAnswer(),
              value: 3,
              groupValue: storage.selectedAnswer,
              onChanged: (num) {
                setState(() {
                  storage.selectedAnswer = num;
                });
              }),
          answerListTile(
              context: context,
              title: storage.fourthAnswer(),
              value: 4,
              groupValue: storage.selectedAnswer,
              onChanged: (num) {
                setState(() {
                  storage.selectedAnswer = num;
                });
              }),
        ],
      );
    },
  );
}

Widget buildFAB(BuildContext context) {
  JobQuizStorage storage = Get.put(JobQuizStorage());

  return storage.showResults
      ? null
      : FloatingActionButton.extended(
          label: Text('ВЫБРАТЬ'),
          icon: Icon(Icons.check_outlined),
          onPressed: () {
            if (storage.selectedAnswer == 0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Выберите вариант ответа'),
                behavior: SnackBarBehavior.floating,
              ));
            } else {
              storage.chooseAnswer();
            }
          },
        );
}

Widget buildResults(BuildContext context) {
  JobQuizStorage storage = Get.put(JobQuizStorage());

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
                  storage.resultText(),
                  style: Theme.of(context).textTheme.headline3,
                )),
            ButtonBar(
              children: [
                IconButton(
                    tooltip: 'Поделиться результатом',
                    onPressed: () {
                      Share.share(storage.resultText());
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      color: Theme.of(context).accentColor,
                    ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget answerListTile(
    {BuildContext context,
    String title,
    int value,
    int groupValue,
    void onChanged(int value)}) {
  return RadioListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      activeColor: Theme.of(context).accentColor,
      controlAffinity: ListTileControlAffinity.trailing,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged);
}
