import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {


  dynamic getValue(String key) {
    Box settings = Hive.box('settings');
    return settings.get(key);
  }

  void saveValue({String key, dynamic value}) {
    Box settings = Hive.box('settings');
    settings.put(key, value);
  }

  void removeValue(String key) {
    Box settings = Hive.box('settings');
    settings.delete(key);
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('settings');
  }
}
