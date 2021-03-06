import 'package:flutter/material.dart';

class LessonsScheduleScreen extends StatefulWidget {
  @override
  _LessonsScheduleScreenState createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание пар'),
      ),
      body: Center(
        child: Text('LessonsSchedule'),
      ),
    );
  }
}
