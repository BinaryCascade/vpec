import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/time_model.dart';
import '../../ui/widgets/snow_widget.dart';
import '../../ui/widgets/time_card.dart';
import '../../utils/hive_helper.dart';
import '../../utils/holiday_helper.dart';
import '../../utils/theme_helper.dart';

class TimeTableScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimeTableScreenState();
}

class TimeTableScreenState extends State<TimeTableScreen> {
  int pausesCount = 0;

  @override
  void initState() {
    HiveHelper().saveValue(key: 'isLastTime', value: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('time_schedule');
    Stream<QuerySnapshot> stream;
    stream = collectionReference.snapshots();
    return Scaffold(
      body: Stack(children: <Widget>[
        if (HolidayHelper().isNewYear())
          SnowWidget(
            isRunning: true,
            totalSnow: 20,
            speed: 0.4,
            snowColor:
                ThemeHelper().isDarkMode() ? Colors.white : Color(0xFFD6D6D6),
          ),
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 30),
          child: StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return _buildLoadingIndicator();
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                children: snapshot.data.docs.map((document) {
                  return TimeScheduleCard(
                    time: TimeModel.fromMap(document.data(), document.id),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ]),
    );
  }

  Center _buildLoadingIndicator() {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: height / 2.4,
        ),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
