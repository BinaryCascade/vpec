// this model used in TimeTable

class TimeModel {
  final String? startLesson;
  final String? endLesson;
  final String? pause;
  final String? name;
  final String? id;

  const TimeModel({
    this.startLesson,
    this.endLesson,
    this.pause,
    this.name,
    this.id,
  });

  TimeModel.fromMap(Map<String, dynamic> data, String id)
      : this(
          name: data['name'],
          startLesson: data['start'],
          endLesson: data['end'],
          pause: data['pause'],
          id: id,
        );

  Map<String, dynamic> toMap(int docID) {
    return {
      'name': name,
      'start': startLesson,
      'end': endLesson,
      'pause': pause,
      'order': docID,
    };
  }
}
