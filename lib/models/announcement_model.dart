// this model used for AnnouncementsScreen

import '../utils/firebase_auth.dart';

class AnnouncementModel {
  final String author;
  final String content;
  final String pubDate;
  final String title;
  final String docId;
  final AccountType accessLevel;
  final String? photoUrl;

  const AnnouncementModel({
    required this.author,
    required this.content,
    required this.pubDate,
    required this.title,
    required this.docId,
    required this.accessLevel,
    this.photoUrl,
  });

  AnnouncementModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          pubDate: data['date'],
          author: data['author'],
          content: data['content_body'],
          title: data['content_title'],
          accessLevel: parseAccountType(data['visibility']),
          photoUrl: data['photo'],
          docId: id,
        );

  static AccountType parseAccountType(String data) {
    switch (data) {
      case 'students':
        return AccountType.student;
      case 'teachers':
        return AccountType.teacher;
      case 'parents':
        return AccountType.parent;
      case 'admins':
        return AccountType.admin;
      default:
        return AccountType.entrant;
    }
  }
}
