class TeacherModel {
  final String? familyName;
  final String? firstName;
  final String? secondaryName;
  final String? fullName;
  final String? cabinet;
  final String? lesson;
  final String? id;

  const TeacherModel({
    this.familyName,
    this.firstName,
    this.secondaryName,
    this.fullName,
    this.cabinet,
    this.lesson,
    this.id,
  });

  TeacherModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          familyName: data['familyName'],
          firstName: data['firstName'],
          secondaryName: data['secondaryName'],
          fullName:
              "${data['familyName']} ${data['firstName']} ${data['secondaryName']}",
          cabinet: data['cabinet'],
          lesson: data['lesson'],
          id: id,
        );

  Map<String, dynamic> toMap(int docID) {
    return {
      'familyName': familyName,
      'firstName': firstName,
      'secondaryName': secondaryName,
      'cabinet': cabinet,
      'lesson': lesson,
      'order': docID,
    };
  }
}
