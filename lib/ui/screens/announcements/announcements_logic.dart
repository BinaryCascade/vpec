import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';
import 'package:vpec/utils/hive_helper.dart';

import '../../../utils/rounded_modal_sheet.dart';
import '../../../utils/snackbars.dart';
import 'announcements_ui.dart';

class AnnouncementsLogic {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void createNewAnnouncement(BuildContext context) {
    int docID = DateTime.now().millisecondsSinceEpoch;
    bool isUserAddPhoto = false;
    String userPhotoUrl = '';

    Future<void> pickPhoto() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        isUserAddPhoto = true;
        try {
          var result = await FirebaseStorage.instance
              .ref('announcements/$docID')
              .putFile(file);

          userPhotoUrl = await result.ref.getDownloadURL();
        } on FirebaseException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        }
      }
    }

    String collectionPath(UserMode userMode) {
      switch (userMode) {
        case UserMode.employee:
          return 'announcements_employee';
        case UserMode.teacher:
          return 'announcements_teachers';
        case UserMode.entrant:
          return 'announcements_all';
        default:
          return 'announcements_all';
      }
    }

    void sendNewAlert(
        {required BuildContext context, required UserMode userMode}) async {
      CollectionReference users =
          FirebaseFirestore.instance.collection(collectionPath(userMode));

      DateFormat formatter = DateFormat('HH:mm, d MMM yyyy');
      String pubDate = formatter.format(DateTime.now());

      users
          .doc(docID.toString())
          .set({
            'author': HiveHelper.getValue('username'),
            'content_body': contentController.text,
            'visibility': userMode == UserMode.employee
                ? 'employee'
                : userMode == UserMode.teacher
                    ? 'teachers'
                    : 'all',
            'date': pubDate,
            'content_title': titleController.text,
            'photo': isUserAddPhoto ? userPhotoUrl : null,
            'id': docID.toString(),
          })
          .then((value) => showSnackbar(context, text: 'Объявление отправлено'))
          .catchError((error) => showSnackbar(context, text: 'Ошибка: $error'));
      Navigator.pop(context);
    }

    void confirmAnnouncementSend() {
      roundedModalSheet(
          context: context,
          title: 'Кому отправить?',
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: Theme.of(context).outlinedButtonTheme.style,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  onPressed: () =>
                      sendNewAlert(context: context, userMode: UserMode.student),
                  child: Text(
                    'Отправить всем',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  onPressed: () =>
                      sendNewAlert(context: context, userMode: UserMode.employee),
                  child: Text(
                    'Отправить сотрудникам',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  onPressed: () =>
                      sendNewAlert(context: context, userMode: UserMode.teacher),
                  child: Text(
                    'Отправить преподавателям',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
              ),
            ],
          ));
    }

    roundedModalSheet(
      context: context,
      title: 'Новое объявление',
      child: NewAnnouncementUI(
        titleController: titleController,
        contentController: contentController,
        isUserAddPhoto: isUserAddPhoto,
        userPhotoUrl: userPhotoUrl,
        pickPhoto: () => pickPhoto(),
        confirmAnnouncementSend: () => confirmAnnouncementSend(),
      ),
    );
  }
}
