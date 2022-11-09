import 'dart:async';
import 'dart:convert';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/full_schedule.dart';
import '../../models/schedule/group_definition.dart';
import '../../models/schedule/schedule.dart';
import '../../models/schedule/timetable.dart';
import '../../utils/hive_helper.dart';
import 'schedule_screen.dart';

class ScheduleLogic extends ChangeNotifier {
  /// Contains all the information about the schedule
  /// (timetable, schedule, shortLessonNames, fullLessonNames, teachers)
  FullSchedule? fullSchedule;

  /// Indicates whether schedule is being shown for today or not
  bool showingForToday = true;

  /// String of the format "dd-MM-yyyy", which shows the currently selected date
  String showingData = DateFormat('dd-MM-yyyy').format(DateTime.now());

  /// Indicates active lesson
  int activeLessonIndex = 0;

  /// Indicates whether an error occurred during data processing or not
  bool hasError = false;

  /// Used for textual notification of errors to the user in [ScheduleScreen]
  String? errorText;

  /// Used for automatically update timetable
  ///
  /// call [startTimersUpdating] to start updating.
  Timer? _timer;

  /// Used for time counting
  bool _needPrintTimer = true;
  Duration _smallestUntilStartDuration = const Duration(days: 2);

  /// Convert [showingData] to human readability text at russian, e.g
  ///
  /// 27 января 2021
  String get printCurrentDate {
    DateTime parsed = DateFormat('d-M-yyyy', 'ru').parse(showingData);
    DateFormat formatter = DateFormat('d MMMM yyyy');

    return formatter.format(parsed);
  }

  // TODO: uncomment when new schedule system is ready on the college's website
  //  Accepts date and converts to schedule URL
  String _makeUrl(String date) => 'https://energocollege.ru/vec_assistant/'
      '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/'
      '$date.json';

  // /// Accepts date and converts to schedule URL in **debug** mode
  // String _makeUrl(String date) =>
  //     'https://raw.githubusercontent.com/ShyroTeam/vpec/'
  //     'v2.0.0/assets/schedule_json_example/'
  //     '$date.json';

  /// Switch schedule display to today or tomorrow
  Future<void> toggleShowingLesson() async {
    showingForToday = !showingForToday;
    notifyListeners();
    await loadSchedule();
  }

  /// Gets required date and parses schedule
  ///
  /// Returns [true] if parse was successful
  Future<bool> loadSchedule() async {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    int plusDays = 0;
    int today = date.weekday;
    bool isWeekend = false;
    switch (today) {
      case DateTime.friday:
        plusDays = 3;
        break;
      case DateTime.saturday:
        plusDays = 2;
        isWeekend = true;
        break;
      case DateTime.sunday:
        plusDays = 1;
        isWeekend = true;
        break;
      default:
        plusDays = 1;
        break;
    }

    if (!showingForToday || isWeekend) {
      date = date.add(Duration(days: plusDays));
      if (isWeekend) showingForToday = false;
    }
    showingData = formatter.format(date);

    await _getActualData(_makeUrl(showingData));

    return fullSchedule != null;
  }

  /// Show DatePicker dialog for schedule, if user pick one of the days,
  /// then load picked schedule
  Future<void> chooseData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      showingData = formatter.format(picked);
      await _getActualData(_makeUrl(showingData));
    }
  }

  /// Parse full schedule from given [url]
  Future<void> _getActualData(String url) async {
    // clear old data
    fullSchedule = null;

    late String scheduleData;

    try {
      var file = await DefaultCacheManager().getSingleFile(url);
      scheduleData = utf8.decode(await file.readAsBytes());
      hasError = false;
    } catch (e) {
      http.Response response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 90));

      if (response.statusCode == 200) {
        DefaultCacheManager().putFile(url, response.bodyBytes);
        hasError = false;
        scheduleData = response.body;
      } else {
        hasError = true;
        errorText = getErrorTextByStatusCode(response.statusCode);
      }
    }

    if (!hasError) {
      String group = await HiveHelper.getValue('chosenGroup') ?? '';

      if (group.isNotEmpty) {
        fullSchedule = FullSchedule(
          timetable: _getTimetable(scheduleData, group),
          schedule: _getSchedule(scheduleData, group),
          shortLessonNames: _getGroupDefinition(scheduleData, '${group}_short'),
          fullLessonNames: _getGroupDefinition(scheduleData, '${group}_full'),
          teachers: _getGroupDefinition(scheduleData, '${group}_teacher'),
          groups: group,
        );

        // get timers for this schedule
        getTimers();
      } else {
        hasError = true;
        errorText = 'Не выбрана группа для показа расписания';
      }
    }

    notifyListeners();
  }

  /// Parse [Timetable] from [data] for this [group]
  Map<String, dynamic> _getTimetable(String data, String group) {
    return Timetable.fromJson(json.decode(data)).timetableMap[group];
  }

  /// Parse [Schedule] from [data] for this [group]
  Map<String, dynamic> _getSchedule(String data, String group) {
    return Schedule.fromJson(json.decode(data)).scheduleMap[group];
  }

  /// Parse [GroupDefinition] from [data] for this [group]
  Map<String, dynamic> _getGroupDefinition(String data, String group) {
    return GroupDefinition.fromJson(json.decode(data))
        .groupDefinitionMap[group];
  }

  /// Sets new active lesson with given [index].
  void setActiveLesson(int index) {
    activeLessonIndex = index;
    notifyListeners();
  }

  /// Converts basic status codes into text errors that are
  /// understandable to the user
  String? getErrorTextByStatusCode(int statusCode) {
    switch (statusCode) {
      case 404: // Not found
        return 'Расписание занятий на данный день не найдено.\n\n'
            'Если уверены, что расписание занятий доступно, '
            'попробуйте открыть полное расписание';
      case 408: // Request Timeout
        return 'Похоже, что нет ответа от сервера\n\n'
            'Проверьте подключение к сети';
      default: // Any other code
        return null;
    }
  }

  /// Gets or updates timers for actual [fullSchedule]
  ///
  /// Timer - is a string format 'До конца: 28 минут'
  void getTimers() {
    if (fullSchedule != null) {
      DateTime now = DateTime.now();

      List<String?> timers = fullSchedule!.timers; // immutable list
      List<String?> newTimers = []; // mutable list
      newTimers.addAll(timers);

      fullSchedule!.timetable.forEach((key, value) {
        // parse time for current lesson

        // raw time in string
        String beginning = value.split('-').first;
        String ending = value.split('-').last;

        // String time converted to DateTime
        DateTime lessonBeginning = DateFormat('HH:mm').parse(beginning);
        DateTime lessonEnding = DateFormat('HH:mm').parse(ending);

        // DateTime time converted to Duration
        Duration nowDuration =
            Duration(hours: now.hour, minutes: now.minute, seconds: now.second);
        Duration startDuration = Duration(
          hours: lessonBeginning.hour,
          minutes: lessonBeginning.minute,
        );
        Duration endDuration =
            Duration(hours: lessonEnding.hour, minutes: lessonEnding.minute);

        if (nowDuration >= startDuration && nowDuration < endDuration) {
          _needPrintTimer = false;
          setActiveLesson(int.parse(key));

          newTimers.insert(
            int.parse(key),
            'До конца: ${_getTime(endDuration - nowDuration)}',
          );

          fullSchedule = fullSchedule!.copyWith(
            timers: newTimers,
          );

          if (endDuration - nowDuration <= const Duration(seconds: 1)) {
            _smallestUntilStartDuration = const Duration(days: 2);
            _needPrintTimer = true;
          }
        } else {
          if (nowDuration < startDuration &&
              _needPrintTimer &&
              startDuration - nowDuration <= _smallestUntilStartDuration) {
            _smallestUntilStartDuration = startDuration - nowDuration;
            newTimers.insert(
              int.parse(key),
              'До начала: ${_getTime(startDuration - nowDuration)}',
            );

            fullSchedule = fullSchedule!.copyWith(
              timers: newTimers,
            );
          } else {
            newTimers.insert(int.parse(key), '');
          }
        }
      });
      notifyListeners();
    }
  }

  /// Convert [duration] to human readability text at russian, e.g
  ///
  /// 34 минуты
  String _getTime(Duration duration) {
    return prettyDuration(
      Duration(minutes: duration.inMinutes + 1),
      locale: const RussianDurationLanguage(),
    );
  }

  /// Start automatically updating timers for actual timetable
  void startTimersUpdating() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => getTimers(),
    );
  }

  /// Stop automatically updating timers for actual timetable
  void cancelTimersUpdating() {
    if (_timer != null) _timer!.cancel();
  }
}

class ScheduleTime {
  /// Calculates a pause based on two parameters:
  ///
  /// [lessonEnding] - end time of current lesson
  ///
  /// [nextLessonBeginning] - beginning time of next lesson
  ///
  /// **All strings must be 'HH:mm' format**
  static String calculatePauseAfterLesson(
    String lessonEnding,
    String nextLessonBeginning,
  ) {
    DateTime dateLessonEnding = DateFormat('HH:mm').parse(lessonEnding);
    DateTime dateNextLessonBeginning =
        DateFormat('HH:mm').parse(nextLessonBeginning);

    String pause = prettyDuration(
      dateNextLessonBeginning.difference(dateLessonEnding),
      locale: DurationLocale.fromLanguageCode('ru')!,
    );
    pause = pause.replaceAll('0 секунд', '');
    if (pause.isNotEmpty) pause = 'Перемена: $pause';

    return pause;
  }

  /// Replaces the short name of the lesson with the full name of the lesson.
  ///
  /// Short names should be provided in [lessonShortNames].
  ///
  /// Full names should be provided in [lessonFullNames].
  ///
  /// [shortLessonName] is a name of the lesson to replace.
  ///
  ///
  ///
  /// The order of the names in [lessonShortNames] and [lessonFullNames]
  /// should be the same.
  static String replaceLessonName({
    required String shortLessonName,
    required Map<String, dynamic> lessonShortNames,
    required Map<String, dynamic> lessonFullNames,
  }) {
    return lessonShortNames.containsValue(shortLessonName)
        ? lessonFullNames[lessonShortNames.keys
            .firstWhere((k) => lessonShortNames[k] == shortLessonName)]
        : shortLessonName;
  }
}
