class Announcement {
  final String author;
  final String content;
  final String pubDate;
  final String title;
  final String docId;
  final bool isPublic;

  const Announcement({
    this.author,
    this.content,
    this.pubDate,
    this.title,
    this.docId,
    this.isPublic,
  });

  Announcement.fromMap(Map<String, dynamic> data, String id)
      : this(
          pubDate: data['pubDate'],
          author: data['author'],
          content: data['content'],
          title: data['title'],
          isPublic: data['isPublic'],
          docId: id,
        );
}
