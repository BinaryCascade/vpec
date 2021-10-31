import 'package:flutter/material.dart';

class BottomBarLogic extends ChangeNotifier {
  int bottomBarIndex = 0;

  void setIndex(int value) {
    bottomBarIndex = value;
    notifyListeners();
  }
}
