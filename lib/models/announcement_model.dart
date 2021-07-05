// this model used for AnnouncementsScreen

import 'package:vpec/ui/screens/settings/settings_logic.dart';

class AnnouncementModel {
  final String author;
  final String content;
  final String pubDate;
  final String title;
  final String docId;
  final UserMode userMode;
  final String? photoUrl;

  const AnnouncementModel({
    required this.author,
    required this.content,
    required this.pubDate,
    required this.title,
    required this.docId,
    required this.userMode,
    this.photoUrl,
  });

  AnnouncementModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          pubDate: data['date'],
          author: data['author'],
          content: data['content_body'],
          title: data['content_title'],
          userMode: data['visibility'] == 'all'
              ? UserMode.entrant
              : data['visibility'] == 'teachers'
                  ? UserMode.teacher
                  : data['visibility'] == 'employee'
                      ? UserMode.employee
                      : UserMode.entrant,
          photoUrl: data['photo'],
          docId: id,
        );
}
