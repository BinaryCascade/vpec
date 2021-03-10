import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LessonsScheduleScreen extends StatefulWidget {
  @override
  _LessonsScheduleScreenState createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen> {
  bool todayController = true;
  String imgUrl = '';

  @override
  Widget build(BuildContext context) {
    imgUrl = _getUrl(true);

    return Scaffold(
      body: InteractiveViewer(
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            key: UniqueKey(),
            errorWidget: (context, url, error) => Center(
              child: Text(error),
            ),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).accentColor,
            mini: true,
            child: Icon(Icons.share_outlined),
            onPressed: () => print('_onShareFABPressed'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).accentColor,
              mini: true,
              child: Icon(Icons.today_outlined),
              onPressed: () => print('date'),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).accentColor,
            child: Icon(todayController ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_rounded, size: 24),
            onPressed: () {todayController = !todayController;
              imgUrl = _getUrl(todayController);

              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String _getUrl(bool forToday) {
    String baseUrl =
        'http://energocollege.ru/vec_assistant/%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/';
    String endUrl = '.jpg';

    var now = DateTime.now();
    int _plusDays = 0;
    var today = now.weekday;
    switch (today) {
      case DateTime.friday:
        _plusDays = 3;
        break;
      case DateTime.saturday:
        _plusDays = 2;
        break;
      case DateTime.sunday:
        _plusDays = 1;
        break;
      default:
        _plusDays = 1;
        break;
    }

    var nextDay = now.add(Duration(days: _plusDays));
    var formatter = DateFormat('d-M-yyyy');

    print(todayController);
    return baseUrl +
        (forToday ? formatter.format(now) : formatter.format(nextDay)) +
        endUrl;
  }
}
