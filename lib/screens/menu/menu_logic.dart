import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../utils/firebase_auth.dart';

class MenuLogic {
  static Future<bool> get isOpenDoorsDay async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('misc_settings')
        .doc('open_doors')
        .get();

    Timestamp timestamp = document['date'];
    String dateOpenDoors = DateFormat('d-MM-yyyy').format(timestamp.toDate());
    String now = DateFormat('d-MM-yyyy').format(DateTime.now());

    return dateOpenDoors == now &&
        AccountDetails.getAccountLevel == AccountType.student;
  }
}
