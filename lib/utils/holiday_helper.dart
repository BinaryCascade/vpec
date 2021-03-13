class HolidayHelper {
  bool isNewYear() {
    var date = DateTime.now();
    if (date.month == 1 || date.month == 12) {
      return true;
    } else {
      return false;
    }
  }
}
