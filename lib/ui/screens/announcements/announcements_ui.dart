import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';
import 'package:vpec/utils/rounded_modal_sheet.dart';

import '../../../models/announcement_model.dart';
import '../../../ui/widgets/announcement_card.dart';

/// ListView with data from Firestore
class AnnouncementsList extends StatelessWidget {
  final String collectionPath;
  const AnnouncementsList({Key key, this.collectionPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _semicircleController = ScrollController();
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection(collectionPath).snapshots();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Произошла ошибка при получении данных, пожалуйста, '
                      'войдите в аккаунт',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              if (!snapshot.hasData) return LoadingIndicator();

              return DraggableScrollbar.semicircle(
                backgroundColor: Theme.of(context).primaryColor,
                child: ListView(
                  controller: _semicircleController,
                  children: snapshot.data.docs
                      .map((document) {
                        return AnnouncementCard(
                            announcement: AnnouncementModel.fromMap(
                                document.data(), document.id));
                      })
                      .toList()
                      .reversed
                      .toList(),
                ),
                controller: _semicircleController,
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnnouncementSendUI extends StatelessWidget {
  final Function sendToAll, sendPrivate;

  const AnnouncementSendUI({
    Key key,
    this.sendToAll,
    this.sendPrivate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            onPressed: () => sendToAll,
            child: Text(
              'Отправить всем',
              style:
                  TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style,
            onPressed: () => sendPrivate,
            child: Text(
              'Отправить сотрудникам',
              style:
                  TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
            ),
          ),
        )
      ],
    );
  }
}

class NewAnnouncementUI extends StatelessWidget {
  const NewAnnouncementUI({
    Key key,
    @required this.titleController,
    @required this.contentController,
    @required this.isUserAddPhoto,
    @required this.userPhotoUrl,
    this.pickPhoto,
    this.confirmAnnouncementSend,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController contentController;
  final bool isUserAddPhoto;
  final String userPhotoUrl;
  final Function pickPhoto, confirmAnnouncementSend;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              TextButton(
                style: Theme.of(context).textButtonTheme.style,
                child: Text(
                  'Фото',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color),
                ),
                onPressed: () async {
                  if (!isUserAddPhoto) {
                    await pickPhoto();
                  } else {
                    roundedModalSheet(
                        context: context,
                        title: 'Ошибка',
                        child: Column(
                          children: [
                            Text(
                              'Фото уже добавлено',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            ButtonBar(
                              children: [
                                OutlinedButton(
                                  style: Theme.of(context)
                                      .outlinedButtonTheme
                                      .style,
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Закрыть',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
                  }
                },
              ),
              Spacer(),
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
                onPressed: () {
                  if (isUserAddPhoto) {
                    if (userPhotoUrl.isNotEmpty) {
                      Navigator.pop(context);
                      confirmAnnouncementSend();
                    } else {
                      roundedModalSheet(
                          context: context,
                          title: 'Внимание',
                          child: Column(
                            children: [
                              Text(
                                'Фото ещё загружается',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              ButtonBar(
                                children: [
                                  OutlinedButton(
                                    style: Theme.of(context)
                                        .outlinedButtonTheme
                                        .style,
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Закрыть',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    }
                  } else {
                    Navigator.pop(context);
                    confirmAnnouncementSend();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
