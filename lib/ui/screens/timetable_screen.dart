import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vpec/models/time_model.dart';
import 'package:vpec/ui/widgets/time_card.dart';

class TimeTableScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimeTableScreenState();
}

class TimeTableScreenState extends State<TimeTableScreen> {
  int pausesCount = 0;

  @override
  void initState() {
    var settings = Hive.box('settings');
    settings.put('isLastTime', true);
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
        // SnowWidget(
        //   isRunning: isNewYear,
        //   totalSnow: 20,
        //   speed: 0.4,
        //   snowColor: Get.isDarkMode ? [Colors.white] : [Color(0xFFD6D6D6)],
        // ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
                width: 1,
              ),
              StreamBuilder(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
            ],
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