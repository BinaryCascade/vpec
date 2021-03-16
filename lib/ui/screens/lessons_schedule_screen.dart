import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:vpec/ui/widgets/snow_widget.dart';
import 'package:vpec/utils/holiday_helper.dart';
import 'package:vpec/utils/theme_helper.dart';

class LessonsScheduleScreen extends StatefulWidget {
  @override
  _LessonsScheduleScreenState createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen> {
  final imageZoomController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();
  bool showForToday = true;
  String baseUrl = 'http://energocollege.ru/vec_assistant/'
      '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/';
  String endUrl = '.jpg';
  String imgUrl = '';

  @override
  void initState() {
    imgUrl = _getUrl(forToday: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          if (HolidayHelper().isNewYear())
            SnowWidget(
              isRunning: true,
              totalSnow: 20,
              speed: 0.4,
              snowColor:
                  ThemeHelper().isDarkMode() ? Colors.white : Color(0xFFD6D6D6),
            ),
          CachedNetworkImage(
            imageUrl: imgUrl,
            errorWidget: (context, url, error) => Center(
              child: SelectableText(
                'Расписание не найдено',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            imageBuilder: (context, imageProvider) => ColorFiltered(
              colorFilter:
                  ThemeHelper().isDarkMode()
                      ? ColorFilter.matrix([
                          //R G  B  A  Const
                          -0.87843, 0, 0, 0, 255,
                          0, -0.87843, 0, 0, 255,
                          0, 0, -0.87843, 0, 255,
                          0, 0, 0, 1, 0,
                        ])
                      : ColorFilter.matrix([
                          0.96078, 0, 0, 0, 0,
                          0, 0.96078, 0, 0, 0,
                          0, 0, 0.96078, 0, 0,
                          0, 0, 0, 1, 0,
                        ]),
              child: Center(
                  child: ExtendedImage(
                      image: imageProvider,

                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (!kIsWeb)
            FloatingActionButton(
              mini: true,
              child: Icon(Icons.share_outlined),
              onPressed: () => _shareLessonImage(imgUrl),
            ),
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: FloatingActionButton(
              mini: true,
              child: Icon(Icons.today_outlined),
              onPressed: () => _chooseDate(context),
            ),
          ),
          FloatingActionButton(
            child: Icon(
                showForToday
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_rounded,
                size: 24),
            onPressed: () {
              // this FAB used for switch between schedule for today or tomorrow
              showForToday = !showForToday;
              imgUrl = _getUrl(forToday: showForToday);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String _getUrl({bool forToday}) {
    // get next day to show lesson schedule
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('d-M-yyyy');

    // if we need to show lessons for tomorrow, then we plus days from now
    // isWeekend used for auto showing schedule for next day from screen start
    int _plusDays = 0;
    int today = date.weekday;
    bool isWeekend = false;
    switch (today) {
      case DateTime.friday:
        _plusDays = 3;
        break;
      case DateTime.saturday:
        _plusDays = 2;
        isWeekend = true;
        break;
      case DateTime.sunday:
        _plusDays = 1;
        isWeekend = true;
        break;
      default:
        _plusDays = 1;
        break;
    }

    if (!forToday || isWeekend) {
      date = date.add(Duration(days: _plusDays));
      if (isWeekend) showForToday = false;
    }

    return baseUrl + formatter.format(date) + endUrl;
  }

  Future<void> _shareLessonImage(String downloadUrl) async {
    // download image from given url
    HttpClientRequest request =
        await HttpClient().getUrl(Uri.parse(downloadUrl));
    HttpClientResponse response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);

    // get temp directory, write and share image file
    final Directory tempDir = await getTemporaryDirectory();
    final File file = await File('${tempDir.path}/share.jpg').create();
    await file.writeAsBytes(bytes);

    Share.shareFiles([file.path]);
  }

  Future<void> _chooseDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null && picked != DateTime.now())
      setState(() {
        imgUrl =
            baseUrl + "${picked.day}-${picked.month}-${picked.year}" + endUrl;
      });
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void zoomImage() {
    if (imageZoomController.value != Matrix4.identity()) {
      imageZoomController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      imageZoomController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);

    }
  }
}
