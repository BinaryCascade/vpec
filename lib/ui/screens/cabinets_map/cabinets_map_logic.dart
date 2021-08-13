import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CabinetsMapLogic extends ChangeNotifier {
  int selectedFloor = 1;
  int scaleFactor = 1;
  String nowImageUrl = '';
  var photoController = PhotoViewController();

  void setFloor(int newFloor) {
    selectedFloor = newFloor;
    notifyListeners();
  }

  void setScale(int newScale) {
    scaleFactor = newScale;
    notifyListeners();
  }

  Future<void> updateImage() async {
    nowImageUrl = await getScaledImage();
    notifyListeners();
  }

  Future<String> getScaledImage() async {
    String fieldName = '';
    switch (scaleFactor) {
      case 1:
        fieldName = 'firstScale';
        break;
      case 2:
        fieldName = 'secondScale';
        break;
      default:
        fieldName = 'firstScale';
        break;
    }

    DocumentSnapshot cabMap = await FirebaseFirestore.instance
        .collection('cabinets_map')
        .doc('map_$selectedFloor')
        .get();
    return cabMap[fieldName].toString();
  }

  Future<void> initializeMap() async {
    photoController = photoController..outputStateStream.listen(scaleListener);
    nowImageUrl = await CabinetsMapLogic().getScaledImage();
    notifyListeners();
  }

  void disposeController() {
    photoController.dispose();
  }

  void scaleListener(PhotoViewControllerValue value) {
    if (value.scale! < 2.0) {
      if (scaleFactor != 1) {
        setScale(1);
        updateImage();
      }
    }
    if (value.scale! > 2.0) {
      if (scaleFactor != 2) {
        setScale(2);
        updateImage();
      }
    }
  }
}
