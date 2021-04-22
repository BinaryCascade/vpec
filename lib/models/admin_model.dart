class AdminModel {
  final String? name;
  final String? contact;
  final String? cabinet;
  final String? post;

  const AdminModel({
    this.name,
    this.contact,
    this.cabinet,
    this.post,
  });

  AdminModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          name: data['name'],
          contact: data['contact'],
          cabinet: data['cabinet'],
          post: data['post'],
        );
}
