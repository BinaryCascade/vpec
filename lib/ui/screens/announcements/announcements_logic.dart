import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:vpec/utils/rounded_modal_sheet.dart';

class AnnouncementsLogic {
  void createNewAnnouncement(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    void sendNewAlert(
        {@required BuildContext context, @required bool isForStudent}) async {
      var settings = Hive.box('settings');
      var docID = DateTime.now().millisecondsSinceEpoch;
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: Theme.of(context).outlinedButtonTheme.style,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  onPressed: () =>
                      sendNewAlert(context: context, isForStudent: true),
                  child: Text(
                    'Отправить всем',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  onPressed: () =>
                      sendNewAlert(context: context, isForStudent: false),
                  child: Text(
                    'Отправить сотрудникам',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ),
              )
            ],
          ));
    }

    roundedModalSheet(
      context: context,
      title: 'Новое объявление',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: titleController,
              textInputAction: TextInputAction.next,
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                  labelText: 'Введите заголовок',
                  labelStyle: Theme.of(context).textTheme.headline3,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).accentColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 200, maxHeight: 200),
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
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).accentColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                style: Theme.of(context).textButtonTheme.style,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Отмена',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
              OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style,
                child: Text(
                  'Отправить',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  confirmAnnouncementSend(),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}