import 'dart:convert';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/full_schedule.dart';
import '../../models/schedule/group_definition.dart';
import '../../models/schedule/schedule.dart';
import '../../models/schedule/timetable.dart';
import '../../utils/hive_helper.dart';

class ScheduleLogic extends ChangeNotifier {
  FullSchedule? fullSchedule;
  bool showingForToday = true;
  String showingData = DateFormat('dd-MM-yyyy').format(DateTime.now());

  // String _makeUrl(String date) => 'https://energocollege.ru/vec_assistant/'
  //     '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/'
  //     '$date.json';

  String get printCurrentDate {
    DateTime parsed = DateFormat('d-M-yyyy', 'ru').parse(showingData);
    DateFormat formatter = DateFormat('d MMMM yyyy');

    return formatter.format(parsed);
  }

  String _makeUrl(String date) =>
      'https://raw.githubusercontent.com/ShyroTeam/vpec/'
      'new_schedule_system/assets/'
      '$date.json';

  Future<void> toggleLesson() async {
    showingForToday = !showingForToday;
    notifyListeners();
    await showLessons();
  }

  Future<bool> showLessons() async {
    // get next day to show lesson schedule
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    // if we need to show lessons for tomorrow, then we plus days from now
    // _isWeekend used for auto showing schedule for next day from screen start
    int _plusDays = 0;
    int _today = date.weekday;
    bool _isWeekend = false;
    switch (_today) {
      case DateTime.friday:
        _plusDays = 3;
        break;
      case DateTime.saturday:
        _plusDays = 2;
        _isWeekend = true;
        break;
      case DateTime.sunday:
        _plusDays = 1;
        _isWeekend = true;
        break;
      default:
        _plusDays = 1;
        break;
    }

    if (!showingForToday || _isWeekend) {
      date = date.add(Duration(days: _plusDays));
      if (_isWeekend) showingForToday = false;
    }
    showingData = formatter.format(date);

    await _getActualData(_makeUrl(showingData));
    return true;
  }

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

  Future<void> _getActualData(String url) async {
    if (kDebugMode) print('called: _getActualData($url)');

    //TODO: add data caching
    String utf8data =
        await http.read(Uri.parse(url)).timeout(const Duration(seconds: 70));
    if (kDebugMode) print('reading success');

    // String utf8data = utf8.decode(rawData.codeUnits);

    if (kDebugMode) print('trying to update');

    // TODO: throw error if [chosenGroup] is null or try to ask chose group
    String group = await HiveHelper.getValue('chosenGroup') ?? '09.02.01-1-18';
    fullSchedule = FullSchedule(
      timetable: _getTimetable(utf8data, group),
      schedule: _getSchedule(utf8data, group),
      shortLessonNames: _getGroupDefinition(utf8data, group + '_short'),
      fullLessonNames: _getGroupDefinition(utf8data, group + '_full'),
      teachers: _getGroupDefinition(utf8data, group + '_teacher'),
      groups: group,
      jsonData: utf8data,
    );
    if (kDebugMode) print('updated');

    notifyListeners();
  }

  Map<String, dynamic> _getTimetable(String data, String group) {
    return Timetable.fromJson(json.decode(data)).timetableMap[group];
  }

  Map<String, dynamic> _getSchedule(String data, String group) {
    return Schedule.fromJson(json.decode(data)).scheduleMap[group];
  }

  Map<String, dynamic> _getGroupDefinition(String data, String group) {
    return GroupDefinition.fromJson(json.decode(data))
        .groupDefinitionMap[group];
  }
}

class ScheduleTime extends ChangeNotifier {
  static String calculatePauseAfterLesson(
    String lessonEnding,
    String nextLessonBeginning,
  ) {
    DateTime dateLessonEnding = DateFormat('HH:mm').parse(lessonEnding);
    DateTime dateNextLessonBeginning =
        DateFormat('HH:mm').parse(nextLessonBeginning);

    String pause = prettyDuration(
        dateNextLessonBeginning.difference(dateLessonEnding),
        locale: DurationLocale.fromLanguageCode('ru')!);
    pause = pause.replaceAll('0 секунд', '');
    if (pause.isNotEmpty) pause = 'Перемена: $pause';
    return pause;
  }

  static String replaceLessonName(
      {required String shortLessonName,
        required Map<String, dynamic> lessonShortNames,
        required Map<String, dynamic> lessonFullNames}) {
    if (lessonFullNames.containsValue(shortLessonName)) {
      return lessonFullNames[shortLessonName.indexOf(shortLessonName)];
    } else {
      return shortLessonName;
    }
  }
}
