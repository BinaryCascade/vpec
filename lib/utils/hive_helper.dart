import 'package:hive/hive.dart';

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

}