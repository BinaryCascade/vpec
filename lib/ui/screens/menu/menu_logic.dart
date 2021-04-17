import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MenuLogic {
  Future<bool> get isOpenDoorsDay async {
    DocumentSnapshot cabMap = await FirebaseFirestore.instance
        .collection('misc_settings')
        .doc('open_doors')
        .get();
    Timestamp timestamp = cabMap['date'];
    String dateOpenDoors = DateFormat('d-MM-yyyy').format(timestamp.toDate());
    String now = DateFormat('d-MM-yyyy').format(DateTime.now());
    if (dateOpenDoors == now) {
      return true;
    } else {
      return false;
    }
  }
}
