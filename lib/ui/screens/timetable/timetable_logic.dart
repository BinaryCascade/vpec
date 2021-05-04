import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpec/ui/widgets/confirm_delete_dialog.dart';

import '../../../models/time_model.dart';
import '../../../utils/rounded_modal_sheet.dart';
import 'timetable_ui.dart';

class TimeTableLogic {
  void resetTimeTable(BuildContext context) {
    roundedModalSheet(
        context: context,
        title: 'Сбросить расписание звонков',
        child: Provider(
            create: (_) => TimeTableLogic(), child: ResetTimeTableDialogUI()));
  }

  void addTimeTable(BuildContext context) {
    roundedModalSheet(
        context: context,
        title: 'Добавить расписание звонков',
        child: AddTimeTableItemDialogUI());
  }

  bool validateToDate(String value) {
    RegExp regex = RegExp(r'^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$');
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  void addNewTimeTableItem(TimeModel model) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection('time_schedule');

    int docID = DateTime.now().millisecondsSinceEpoch;
    schedule.doc(docID.toString()).set(model.toMap(docID));
  }

  void startRestoringTimeSchedule(bool isThirtyMinBreak) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection('time_schedule');

    // delete all docs in time_schedule
    schedule.get().then((value) {
      for (DocumentSnapshot doc in value.docs) {
        doc.reference.delete();
      }
    });

    // add default time schedule
    schedule.get().then((value) {
      for (int i = 1; i < 6; i++) {
        int docID = DateTime.now().millisecondsSinceEpoch;
        schedule
            .doc(docID.toString())
            .set(
              getDefaultTimeSchedule(
                      isThirtyMinBreak: isThirtyMinBreak, numOfLesson: i)
                  .toMap(docID),
            )
            .then((value) => print(
                'Добавлено - ${getDefaultTimeSchedule(isThirtyMinBreak: isThirtyMinBreak, numOfLesson: i)}'))
            .catchError((error) => print('$i - Ошибка: $error'));
      }
    });
  }

  TimeModel getDefaultTimeSchedule(
      {required bool isThirtyMinBreak, required int numOfLesson}) {
    switch (numOfLesson) {
      case 1:
        return TimeModel(
          startLesson: '08:30',
          endLesson: '10:00',
          name: '1 пара',
          pause: '10 минут',
        );
      case 2:
        return TimeModel(
          startLesson: '10:10',
          endLesson: '11:40',
          name: '2 пара',
          pause: isThirtyMinBreak ? '30 минут' : '40 минут',
        );
      case 3:
        return TimeModel(
          startLesson: isThirtyMinBreak ? '12:20' : '12:10',
          endLesson: isThirtyMinBreak ? '13:50' : '13:40',
          name: '3 пара',
          pause: '10 минут',
        );
      case 4:
        return TimeModel(
          startLesson: isThirtyMinBreak ? '14:00' : '13:50',
          endLesson: isThirtyMinBreak ? '15:30' : '15:20',
          name: '4 пара',
          pause: '10 минут',
        );
      case 5:
        return TimeModel(
          startLesson: isThirtyMinBreak ? '15:40' : '15:30',
          endLesson: isThirtyMinBreak ? '17:10' : '17:00',
          name: '5 пара',
          pause: '0 минут',
        );
      default:
        return TimeModel(
          startLesson: '08:00',
          endLesson: '08:10',
          name: 'Указаны неправильные данные',
          pause: 'Проверьте правильность ввода',
        );
    }
  }

  void editTimeTableItem(String docID, TimeModel model) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection('time_schedule');
    schedule
        .doc(docID.toString())
        .set(
          model.toMap(int.parse(docID)),
        )
        .then((value) => print('Отредактировано'))
        .catchError((error) => print('Ошибка редактирования: $error'));
  }

  void confirmDelete(BuildContext context, TimeModel model) {
    Navigator.pop(context);
    roundedModalSheet(
        context: context,
        title: 'Подтвердите действие',
        child: DeleteDialogUI(
          onDelete:() {
            deleteDoc(model.id!);
          },
        ));
  }

  void deleteDoc(String docID) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection('time_schedule');
    schedule
        .doc(docID.toString())
        .delete()
        .then((value) => print('Удалено'))
        .catchError((error) => print('Ошибка удаления: $error'));
  }
}
