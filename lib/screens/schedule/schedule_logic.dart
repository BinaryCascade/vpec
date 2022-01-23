import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/full_schedule.dart';
import '../../models/schedule/group_definition.dart';
import '../../models/schedule/schedule.dart';
import '../../models/schedule/timetable.dart';
import '../../utils/hive_helper.dart';

class ScheduleLogicTest extends ChangeNotifier {
  late String data;
  String group = HiveHelper.getValue('chosenGroup') ?? '09.02.01-1-18';
  late Map<String, dynamic> schedule;
  late Map<String, dynamic> timetable;
  late Map<String, dynamic> groupDefinition;
  int activeLessonIndex = 0;

  String _makeUrl(String date) => 'https://energocollege.ru/vec_assistant/'
      '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/'
      '$date.json';

  Future<bool> getData({String? url}) async {
    if (url != null) {
      print('Trying to load this: $url');
    } else {
      // if url is not provided, then load schedule for today
      DateTime now = DateTime.now();
      _makeUrl('${now.year}-${now.month}-${now.day}');
    }

    url =
        'https://firebasestorage.googleapis.com/v0/b/vec-mobile.appspot.com/o/2021-09-01.json?alt=media&token=474c23ec-248c-4d4c-a203-f06eb4a35c35';
    String dataString = await http.read(Uri.parse(url));

    data = utf8.decode(dataString.codeUnits);
    _getTimetable();
    _getSchedule();
    _getGroupDefinition();
    notifyListeners();
    return true;
  }

  void _getTimetable() =>
      timetable = Timetable.fromJson(jsonDecode(data)).timetableMap[group];

  void _getSchedule() =>
      schedule = Schedule.fromJson(jsonDecode(data)).scheduleMap[group];

  void _getGroupDefinition() => groupDefinition =
      GroupDefinition.fromJson(jsonDecode(data)).groupDefinitionMap[group];

  Future<void> chooseData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      getData(url: _makeUrl('${picked.year}-${picked.month}-${picked.day}'));
    }
    notifyListeners();
  }
}

class ScheduleLogicNew extends ChangeNotifier {
  late FullSchedule fullSchedule;
  bool showingForToday = true;
  String showingData = DateFormat('dd-MM-yyyy').format(DateTime.now());

  // String _makeUrl(String date) => 'https://energocollege.ru/vec_assistant/'
  //     '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/'
  //     '$date.json';

  String _makeUrl(String date) => 'https://localhost/'
      '$date.json';

  void showLessons({required bool forToday}) {
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

    if (!forToday || _isWeekend) {
      date = date.add(Duration(days: _plusDays));
      if (_isWeekend) showingForToday = false;
    }
    showingData = formatter.format(date);
    _getActualData(_makeUrl(showingData));
  }

  Future<void> chooseData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      await _getActualData(_makeUrl(showingData));
      notifyListeners();
    }
  }

  Future<void> _getActualData(String url) async {
    //TODO: add data caching
    String rawData = await http.read(Uri.parse(url));
    String utf8data = utf8.decode(rawData.codeUnits);

    // TODO: throw error if [chosenGroup] is null or try to ask chose group
    String group = HiveHelper.getValue('chosenGroup') ?? '09.02.01-1-18';
    fullSchedule = FullSchedule(
      timetable: _getTimetable(utf8data, group),
      schedule: _getSchedule(utf8data, group),
      groupDefinition: _getGroupDefinition(utf8data, group),
      groups: group,
      jsonData: utf8data,
    );
    notifyListeners();
  }

  Map<String, dynamic> _getTimetable(String data, String group) {
    return Timetable.fromJson(jsonDecode(data)).timetableMap[group];
  }

  Map<String, dynamic> _getSchedule(String data, String group) {
    return Schedule.fromJson(jsonDecode(data)).scheduleMap[group];
  }

  Map<String, dynamic> _getGroupDefinition(String data, String group) {
    return GroupDefinition.fromJson(jsonDecode(data)).groupDefinitionMap[group];
  }
}
