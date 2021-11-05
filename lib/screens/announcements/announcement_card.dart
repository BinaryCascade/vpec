import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import '/models/announcement_model.dart';
import '/screens/settings/settings_logic.dart';
import '/utils/utils.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementCard({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onDoubleTap: () => editAnnouncement(context),
          child: Column(
            children: [
              if (announcement.photoUrl != null)
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: CachedNetworkImage(imageUrl: announcement.photoUrl!),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  title: Text(
                    announcement.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SelectableLinkify(
                          text: announcement.content,
                          style: Theme.of(context).textTheme.bodyText1,
                          options: const LinkifyOptions(humanize: true),
                          onOpen: (link) => openUrl(link.url),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            announcement.author + ' • ' + announcement.pubDate,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editAnnouncement(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    if (SettingsLogic.getAccountMode() == UserMode.admin) {
      titleController.text = announcement.title;
      contentController.text = announcement.content;

      showRoundedModalSheet(
        context: context,
        title: 'Редактировать объявление',
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context).textTheme.headline4,
                  decoration:
                      const InputDecoration(labelText: 'Введите заголовок')),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
              child: TextFormField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 10,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration:
                      const InputDecoration(labelText: 'Введите сообщение')),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: () => confirmDelete(context),
                  child: const Text('Удалить'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  child: const Text('Отредактировать'),
                  onPressed: () => updateAnnouncement(
                      context,
                      announcement.docId,
                      titleController.text,
                      contentController.text),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  void updateAnnouncement(BuildContext context, String docId, String titleText,
      String contentText) {
    CollectionReference alerts =
        FirebaseFirestore.instance.collection(collectionPath());
    alerts
        .doc(docId)
        .update({'content_title': titleText, 'content_body': contentText});
    Navigator.pop(context);
  }

  void confirmDelete(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Удалить объявление?',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Отмена'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => deleteAnnouncement(context),
                      child: const Text('Удалить'),
                    ),
                  ),
                ],
              ),
            ));
  }

  void deleteAnnouncement(BuildContext context) {
    CollectionReference alerts =
        FirebaseFirestore.instance.collection(collectionPath());
    alerts.doc(announcement.docId).delete();
    Navigator.pop(context);
  }

  String collectionPath() {
    switch (announcement.userMode) {
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
}