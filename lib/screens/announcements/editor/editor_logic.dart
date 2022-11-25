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

  /// Stores user typed text for title and body
  TextEditingController announcementTitleController = TextEditingController();
  TextEditingController announcementBodyController = TextEditingController();

  /// Stores url for uploaded image. Can be null, if image is not uploaded
  String? photoUrl;

  /// Shows current progress image uploading. Can be null,
  /// if nothing is uploading
  double? photoUploadProgress;

  /// Used as document ID for Firestore document. Also used for photo name.
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

    // checks whether the user has selected a category or not
    publishFor.forEach((key, value) {
      if (value) publishCategoryWasSelected = true;
    });

    publishButtonActive = publishCategoryWasSelected && titleAndBodyWasEntered;
    notifyListeners();
  }

  /// Converts user typed data to [AnnouncementModel] and send it to
  /// upload for every user selected category.
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

  /// Uploads to the Firestore, depending on what the value of the [publishFor]
  /// is equal to.
  ///
  /// Can throw an Exception, if unknown type was received.
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

  /// Opens image picker and listening for picked photo. If photo was picked,
  /// uploads it to Firebase Storage and stores photo link.
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

  /// Deletes uploaded image to Firebase Storage, if something was uploaded.
  /// It is used if the user uploaded a photo and closed the editor.
  void cleanUp() {
    if (photoUrl == null) return;

    FirebaseStorage storage = FirebaseStorage.instance;
    storage.ref('Announcements/$docID').delete();
  }
}
