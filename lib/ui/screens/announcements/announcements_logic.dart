import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

import '../../../utils/rounded_modal_sheet.dart';
import 'announcements_ui.dart';

class AnnouncementsLogic {
  void createNewAnnouncement(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    int docID = DateTime.now().millisecondsSinceEpoch;
    bool isUserAddPhoto = false;
    String userPhotoUrl = '';

    Future<void> pickPhoto() async {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path);
        isUserAddPhoto = true;
        try {
          var result = await FirebaseStorage.instance
              .ref('announcements/$docID')
              .putFile(file);

          userPhotoUrl = await result.ref.getDownloadURL();
        } on FirebaseException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }

    void sendNewAlert(
        {@required BuildContext context, @required bool isForStudent}) async {
      var settings = Hive.box('settings');
      CollectionReference users = FirebaseFirestore.instance
          .collection(isForStudent ? 'alerts' : 'privateAlerts');

      String pubDate = Jiffy().format('HH:mm, d MMM yyyy');
      users
          .doc(docID.toString())
          .set({
            'author': settings.get('username'),
            'content': contentController.text,
            'isPublic': isForStudent,
            'pubDate': pubDate,
            'title': titleController.text,
            'photo': isUserAddPhoto ? userPhotoUrl : null,
          })
          .then((value) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Объявление отправлено'))))
          .catchError((error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Ошибка: $error'))));
      Navigator.pop(context);
    }

    void confirmAnnouncementSend() {
      roundedModalSheet(
          context: context,
          title: 'Кому отправить?',
          child: AnnouncementSendUI(
            sendPrivate: () =>
                sendNewAlert(context: context, isForStudent: false),
            sendToAll: () => sendNewAlert(context: context, isForStudent: true),
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
