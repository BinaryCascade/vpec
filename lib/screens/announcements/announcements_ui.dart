import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vpec/screens/settings/settings_logic.dart';

import '../../../models/announcement_model.dart';
import '../../../ui/widgets/announcement_card.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../../utils/icons.dart';
import '../../../utils/utils.dart';

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
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
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
                ),
              );
            },
          ),
        ),
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
          padding: const EdgeInsets.only(bottom: 10),
          child: TextFormField(
            controller: titleController,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.headline4,
            decoration: const InputDecoration(labelText: 'Введите заголовок'),
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
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(labelText: 'Введите сообщение'),
          ),
        ),
        Row(
          children: [
            ButtonBar(
              children: [
                OutlinedButton(
                  child: const Text('Фото'),
                  onPressed: () async {
                    if (!isUserAddPhoto) {
                      await pickPhoto!();
                    } else {
                      showRoundedModalSheet(
                          context: context,
                          title: 'Ошибка',
                          child: Column(
                            children: [
                              const Text('Фото уже добавлено'),
                              ButtonBar(
                                children: [
                                  OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Закрыть'),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  child: const Text('Отправить'),
                  onPressed: () {
                    if (isUserAddPhoto) {
                      if (userPhotoUrl.isNotEmpty) {
                        Navigator.pop(context);
                        confirmAnnouncementSend!();
                      } else {
                        showRoundedModalSheet(
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
            )
          ],
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
    return Material(
      elevation: 8.0,
      child: Container(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: TabBar(
          padding: EdgeInsets.symmetric(horizontal: needMakeScrollable() ? 24 : 0),
          isScrollable: needMakeScrollable(),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.group_outlined,
                    size: 24,
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
                      size: 24,
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
                      Icons.school_outlined,
                      size: 24,
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
      ),
    );
  }
}
