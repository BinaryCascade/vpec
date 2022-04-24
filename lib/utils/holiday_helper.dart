class HolidayHelper {
  static bool get isNewYear {
    var date = DateTime.now();

    return date.month == 1 || date.month == 12;
  }
// add more holidays if need...
}
