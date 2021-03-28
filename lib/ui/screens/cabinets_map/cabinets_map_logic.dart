import 'package:cloud_firestore/cloud_firestore.dart';

class FloorStorage {
  int selectedFloor = 1;
  int scaleFactor = 1;

  void setFloor(int newFloor) {
    selectedFloor = newFloor;
  }

  void setScale(int newScale) {
    scaleFactor = newScale;
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
}


