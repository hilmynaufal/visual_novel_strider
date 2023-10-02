import 'package:intl/intl.dart';

class DateTimeParse {
  static String parseDateTime(String dateTime) {
    //check if TBA
    if (dateTime == "TBA") {
      return dateTime;
    }
    final inf = DateFormat("yyyy-MM-dd");
    final outf = DateFormat("d MMM yyyy");

    var inputDate = inf.parse(dateTime);
    var outputDate = outf.format(inputDate);

    return outputDate;
  }

  static String getFirstDayInMonth() {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month - 1, 1);
    final inf = DateFormat("yyyy-MM-dd");

    return inf.format(first);
  }

  static String getNow() {
    final inf = DateFormat("yyyyMMdd");
    return inf.format(DateTime.now());
  }
}
