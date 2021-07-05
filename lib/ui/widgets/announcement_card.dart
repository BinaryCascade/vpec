import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';

import '../../models/announcement_model.dart';
import '../../utils/rounded_modal_sheet.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementModel announcement;
  const AnnouncementCard({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onDoubleTap: () => editAnnouncement(context),
          child: Column(
            children: [
              if (announcement.photoUrl != null)
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          onOpen: (link) async {
                            if (await canLaunch(link.url)) {
                              await launch(link.url);
                            } else {
                              throw ('Could not launch ${link.url}');
                            }
                          },
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

      roundedModalSheet(
        context: context,
        title: 'Редактировать объявление',
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                    labelText: 'Введите заголовок',
                    labelStyle: Theme.of(context).textTheme.headline3,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).colorScheme.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).colorScheme.secondary))),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
              child: TextFormField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                    labelText: 'Введите сообщение',
                    alignLabelWithHint: true,
                    labelStyle: Theme.of(context).textTheme.headline3,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).colorScheme.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).colorScheme.secondary))),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () => confirmDelete(context),
                  child: Text(
                    'Удалить',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
                TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Отмена',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ),
                OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(
                    'Отредактировать',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
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
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) => Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Удалить объявление?',
                    style: Theme.of(context).textTheme.headline4,
                  ),
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
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      onPressed: () => deleteAnnouncement(context),
                      child: Text(
                        'Удалить',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
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
      case UserMode.enrollee:
        return 'announcements_all';
      default:
        return 'announcements_all';
    }
  }
}
