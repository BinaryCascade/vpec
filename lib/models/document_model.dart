// this model used in menu_ui

class DocumentModel {
  final String title;
  final String subtitle;
  final String url;

  DocumentModel({
    required this.title,
    required this.subtitle,
    required this.url,
  });

  DocumentModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          title: data['title'],
          subtitle: data['subtitle'],
          url: data['url'],
        );
}
