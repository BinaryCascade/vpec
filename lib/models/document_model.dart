// this model used in menu_ui

class DocumentModel {
  final String title;
  final String subtitle;
  final String url;
  final String type;

  DocumentModel(
      {required this.title,
      required this.subtitle,
      required this.url,
      required this.type});

  DocumentModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          title: data['title'],
          subtitle: data['subtitle'],
          url: data['url'],
          type: data['type'],
        );
}
