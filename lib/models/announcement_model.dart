// this model used for AnnouncementsScreen

class AnnouncementModel {
  final String author;
  final String content;
  final String pubDate;
  final String title;
  final String docId;
  final bool isPublic;
  final String photoUrl;

  const AnnouncementModel({
    this.author,
    this.content,
    this.pubDate,
    this.title,
    this.docId,
    this.isPublic,
    this.photoUrl,
  });

  AnnouncementModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          pubDate: data['pubDate'],
          author: data['author'],
          content: data['content'],
          title: data['title'],
          isPublic: data['isPublic'],
          photoUrl : data['photo'],
          docId: id,
        );
}
