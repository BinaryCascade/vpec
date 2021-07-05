import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vpec/ui/screens/settings/settings_logic.dart';

import '../../../models/announcement_model.dart';
import '../../../ui/widgets/announcement_card.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../../utils/icons.dart';
import '../../../utils/rounded_modal_sheet.dart';

/// ListView with data from Firestore
class AnnouncementsList extends StatelessWidget {
  final String collectionPath;
  const AnnouncementsList({Key? key, required this.collectionPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _semicircleController = ScrollController();
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection(collectionPath)
        .orderBy('id', descending: true)
        .snapshots();

    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: stream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
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
              }
              if (!snapshot.hasData) return const LoadingIndicator();

              return Align(
                alignment: Alignment.topCenter,
                child: Scrollbar(
                  interactive: true,
                  controller: _semicircleController,
                  child: ListView.builder(
                    controller: _semicircleController,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return AnnouncementCard(
                          announcement: AnnouncementModel.fromMap(
                              snapshot.data!.docs[index].data(),
                              snapshot.data!.docs[index].id));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AnnouncementSendUI extends StatelessWidget {
  final Function? sendToAll, sendPrivate;

  const AnnouncementSendUI({
    Key? key,
    this.sendToAll,
    this.sendPrivate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            onPressed: () => sendToAll,
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
            onPressed: () => sendPrivate,
            child: Text(
              'Отправить сотрудникам',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
          ),
        )
      ],
    );
  }
}

class NewAnnouncementUI extends StatelessWidget {
  const NewAnnouncementUI({
    Key? key,
    required this.titleController,
    required this.contentController,
    required this.isUserAddPhoto,
    required this.userPhotoUrl,
    this.pickPhoto,
    this.confirmAnnouncementSend,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController contentController;
  final bool isUserAddPhoto;
  final String userPhotoUrl;
  final Function? pickPhoto, confirmAnnouncementSend;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              TextButton(
                style: Theme.of(context).textButtonTheme.style,
                child: Text(
                  'Фото',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                onPressed: () async {
                  if (!isUserAddPhoto) {
                    await pickPhoto!();
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
                                            .bodyText1!
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
              const Spacer(),
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
                  'Отправить',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                onPressed: () {
                  if (isUserAddPhoto) {
                    if (userPhotoUrl.isNotEmpty) {
                      Navigator.pop(context);
                      confirmAnnouncementSend!();
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
                                              .bodyText1!
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
                    confirmAnnouncementSend!();
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

class BottomTapBar extends StatefulWidget {
  const BottomTapBar({
    Key? key,
  }) : super(key: key);

  @override
  _BottomTapBarState createState() => _BottomTapBarState();
}

class _BottomTapBarState extends State<BottomTapBar> {
  bool needMakeScrollable() {
    if (SettingsLogic.doAccountHaveAccess(UserMode.admin)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: TabBar(
        isScrollable: needMakeScrollable(),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 3.0,
          ),
          insets: const EdgeInsets.only(bottom: kToolbarHeight - 4),
        ),
        labelColor: Theme.of(context).colorScheme.secondary,
        unselectedLabelColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).colorScheme.secondary,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.group_outlined,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Всем',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          if (SettingsLogic.doAccountHaveAccess(UserMode.employee))
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    VpecIconPack.account_cog_outline,
                    size: 28,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Сотрудникам',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          if (SettingsLogic.doAccountHaveAccess(UserMode.teacher))
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    VpecIconPack.account_cog_outline,
                    size: 28,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Преподавателям',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
