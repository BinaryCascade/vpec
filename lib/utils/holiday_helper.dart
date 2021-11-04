class HolidayHelper {
  static bool get isNewYear {
    var date = DateTime.now();
    if (date.month == 1 || date.month == 12) {
      return true;
    } else {
      return false;
    }
  }
  // add more holidays if need...
}