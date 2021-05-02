// this model used in TimeTable

class TimeModel {
  final String? startLesson;
  final String? endLesson;
  final String? pause;
  final String? name;

  const TimeModel({
    this.startLesson,
    this.endLesson,
    this.pause,
    this.name,
  });

  TimeModel.fromMap(Map<String, dynamic> data, String id)
      : this(
    name: data['name'],
    startLesson: data['start'],
    endLesson: data['end'],
    pause: data['pause'],
  );
}