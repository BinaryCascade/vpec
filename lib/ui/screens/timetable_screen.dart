import 'package:flutter/material.dart';

class TimeTableScreen extends StatefulWidget {
  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание звонков'),
      ),
      body: Center(
        child: Text('TimeTable'),
      ),
    );
  }
}
