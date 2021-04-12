import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';
import 'package:vpec/ui/widgets/timetable_item/timetable_item.dart';

import '../../models/time_model.dart';
import '../../ui/widgets/snow_widget.dart';
import '../../utils/holiday_helper.dart';
import '../../utils/theme_helper.dart';

class TimeTableTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection('time_schedule').snapshots();
    return Scaffold(
      body: Stack(children: [
        if (HolidayHelper().isNewYear())
          SnowWidget(
            isRunning: true,
            totalSnow: 20,
            speed: 0.4,
            snowColor:
                ThemeHelper().isDarkMode() ? Colors.white : Color(0xFFD6D6D6),
          ),
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: StreamBuilder(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return LoadingIndicator();
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.docs.map((document) {
                    return TimeTableItem(
                      timeModel:
                          TimeModel.fromMap(document.data(), document.id),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
