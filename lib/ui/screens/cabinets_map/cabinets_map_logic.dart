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
      case 3:
        fieldName = 'thirdScale';
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

  Future<void> init() async {
    photoController = photoController..outputStateStream.listen(listener);
    nowImageUrl = await CabinetsMapLogic().getScaledImage();
    notifyListeners();
  }

  void cancel() {
    photoController.dispose();
  }

  Future<void> listener(PhotoViewControllerValue value) async {
    if (value.scale! < 2.0) {
      if (scaleFactor != 1) {
        setScale(1);
        updateImage();
      }
    }
    if (value.scale! > 2.0 && value.scale! < 3.0) {
      if (scaleFactor != 2) {
        setScale(2);
        updateImage();
      }
    }
    if (value.scale! > 3.0 && value.scale! < 4.0) {
      if (scaleFactor != 3) {
        setScale(3);
        updateImage();
      }
    }
  }
}
