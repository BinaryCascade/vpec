import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:vpec/ui/widgets/loading_indicator.dart';

import '../../ui/widgets/snow_widget.dart';
import '../../utils/holiday_helper.dart';
import '../../utils/theme_helper.dart';

class LessonsScheduleScreen extends StatefulWidget {
  @override
  _LessonsScheduleScreenState createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen> with TickerProviderStateMixin{
  final _transformationController = TransformationController();
  AnimationController _animationController;
  Animation<Matrix4> _animation;
  TapDownDetails _doubleTapDetails;

  bool showForToday = true;
  String baseUrl = 'https://energocollege.ru/vec_assistant/'
      '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/';
  String endUrl = '.jpg';
  String imgUrl = '';

  @override
  void initState() {
    imgUrl = getUrl(forToday: true);
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
      _transformationController.value = _animation.value;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            placeholder: (context, url) => LoadingIndicator(),
            imageBuilder: (context, imageProvider) => GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 10.0,
                transformationController: _transformationController,
                child: ColorFiltered(
                colorFilter: ThemeHelper().isDarkMode()
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
                  child: Image(
                    image: imageProvider,
                  ),
                ),
              ),),
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
              imgUrl = getUrl(forToday: showForToday);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  String getUrl({bool forToday}) {
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

    if (picked != null)
      setState(() {
        imgUrl =
            baseUrl + "${picked.day}-${picked.month}-${picked.year}" + endUrl;
      });
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    // get details about offset of interactive viewer
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      // zoom out
      _endMatrix = Matrix4.identity();
    } else {
      // zoom in
      _endMatrix = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.5);
    }

    // animate zooming
    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

}
