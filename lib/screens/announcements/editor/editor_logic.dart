import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/announcement_model.dart';
import '../../../utils/firebase_auth.dart';
import '../../../utils/hive_helper.dart';

class EditorLogic extends ChangeNotifier {
  /// Shows, should publish button be active or disabled.
  bool publishButtonActive = false;

  TextEditingController announcementTitleController = TextEditingController();
  TextEditingController announcementBodyController = TextEditingController();

  String? photoUrl;

  double? photoUploadProgress;

  int docID = DateTime.now().millisecondsSinceEpoch;

  /// List of publish privacy
  Map<String, bool> publishFor = {
    'students': false,
    'parents': false,
    'teachers': false,
  };

  /// Use for update values from checkboxes in [publishFor]
  void updateCheckbox(final String changeFor, final bool newValue) {
    publishFor.update(changeFor, (_) => newValue);
    checkAndUpdatePublishButtonActiveStatus();
  }

  /// Checks for user selected privacy for creating article, and if nothing
  /// was selected, then disables button.
  void checkAndUpdatePublishButtonActiveStatus() {
    bool publishCategoryWasSelected = false;

    bool titleAndBodyWasEntered =
        announcementTitleController.text.trim().isNotEmpty &&
            announcementBodyController.text.trim().isNotEmpty;

    publishFor.forEach((key, value) {
      if (value) publishCategoryWasSelected = true;
    });

    publishButtonActive = publishCategoryWasSelected && titleAndBodyWasEntered;
    notifyListeners();
  }

  ///
  Future<void> publishAnnouncement() async {
    DateFormat formatter = DateFormat('HH:mm, d MMM yyyy');
    String pubDate = formatter.format(DateTime.now());

    final AnnouncementModel article = AnnouncementModel(
      author: HiveHelper.getValue('username'),
      content: announcementBodyController.text.trim(),
      pubDate: pubDate,
      title: announcementTitleController.text.trim(),
      docId: docID.toString(),
      photoUrl: photoUrl,
      accessLevel: AccountType.admin, // ignore this field
    );

    publishFor.forEach((key, value) async {
      if (value) {
        await _uploadArticle(key, article);
        publishButtonActive = false;
      }
    });
  }

  Future<void> _uploadArticle(String publishFor, AnnouncementModel article) async {
    String collectionPath() {
      switch (publishFor) {
        case 'parents':
          return 'announcements_parents';
        case 'students':
          return 'announcements_students';
        case 'teachers':
          return 'announcements_teachers';
        default:
          throw Exception('Unknown account type');
      }
    }

    CollectionReference announcements =
        FirebaseFirestore.instance.collection(collectionPath());

    await announcements.doc(article.docId).set({
      'author': article.author,
      'content_title': article.title,
      'content_body': article.content,
      'date': article.pubDate,
      'photo': article.photoUrl,
      'id': article.docId,
      'visibility': publishFor,
    });
  }

  ///
  Future<void> pickImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null) return;

    final File image = File(result.files.first.path!);

    final firebaseStorage =
        FirebaseStorage.instance.ref('Announcements/$docID').putFile(image);

    late StreamSubscription uploadingStreamsub;

    uploadingStreamsub = firebaseStorage.snapshotEvents.listen((event) async {
      photoUploadProgress =
          event.bytesTransferred.toDouble() / event.totalBytes.toDouble();

      notifyListeners();
      if (event.state == TaskState.success) {
        photoUrl = await event.ref.getDownloadURL();
        notifyListeners();
        uploadingStreamsub.cancel();
      }
    });
  }
}
