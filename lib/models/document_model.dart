// this model used in menu_ui

class DocumentModel {
  final String title;
  final String subtitle;
  final String? url; // can be null if doc type is MD
  final String? data; // can be null if doc type if PDF
  final String type;

  DocumentModel(
      {required this.title,
      required this.subtitle,
      this.url,
      this.data,
      required this.type});

  DocumentModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          title: data['title'],
          subtitle: data['subtitle'],
          url: data['url'],
          data: data['data'],
          type: data['type'],
        );
}
