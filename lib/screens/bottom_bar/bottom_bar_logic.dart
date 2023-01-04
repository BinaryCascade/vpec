import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class BottomBarLogic extends ChangeNotifier {
  int bottomBarIndex = 0;

  void setIndex(int value) {
    FirebaseAnalytics.instance.logEvent(name: 'bottom_navigation_item_selected', parameters: {
      'index': value,
    });

    bottomBarIndex = value;
    notifyListeners();
  }
}
