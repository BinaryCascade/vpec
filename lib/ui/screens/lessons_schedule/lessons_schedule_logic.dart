import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LessonsScheduleLogic extends ChangeNotifier {
  final transformationController = TransformationController();
  late AnimationController animationController;
  late Animation<Matrix4> animation;
  late TapDownDetails doubleTapDetails;

  bool showForToday = true;
  String baseUrl = 'https://energocollege.ru/vec_assistant/'
      '%D0%A0%D0%B0%D1%81%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5/';
  String endUrl = '.jpg';
  String dateFromUrl = '';
  String imgUrl = '';

  void onInitState(TickerProvider tickerProvider) {
    imgUrl = getUrl(forToday: true);

    animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        transformationController.value = animation.value;
      });
  }

  void onDispose() {
    animationController.dispose();
  }

  void updateImgUrl() {
    imgUrl = getUrl(forToday: showForToday);
    notifyListeners();
  }

  String get parseDateFromUrl {
    DateTime parsed = DateFormat('d-M-yyyy', 'ru').parse(dateFromUrl);
    DateFormat formatter = DateFormat('d MMMM yyyy');

    return formatter.format(parsed);
  }

  String getUrl({required bool forToday}) {
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
    dateFromUrl = formatter.format(date);
    return baseUrl + formatter.format(date) + endUrl;
  }

  Future<void> chooseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018, 8),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      dateFromUrl = '${picked.day}-${picked.month}-${picked.year}';
    }
    imgUrl = baseUrl + dateFromUrl + endUrl;
    notifyListeners();
  }

  void handleDoubleTapDown(TapDownDetails details) {
    // get details about offset of interactive viewer
    doubleTapDetails = details;
  }

  void handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset position = doubleTapDetails.localPosition;

    if (transformationController.value != Matrix4.identity()) {
      // zoom out
      _endMatrix = Matrix4.identity();
    } else {
      // zoom in
      _endMatrix = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.5);
    }

    // animate zooming
    animation = Matrix4Tween(
      begin: transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(animationController),
    );
    animationController.forward(from: 0);
  }
}
