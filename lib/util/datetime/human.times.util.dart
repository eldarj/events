import 'package:intl/intl.dart';

class HumanTimes {
  static String getDateString(String timestamp) {
    return getDate(int.parse(timestamp));
  }

  static int getYear(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.round());
    return date.year;
  }

  static String getDate(int timestamp) {
    final dateFormat = DateFormat('EEEE d. MMM');
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.round());

    return dateFormat.format(date);
  }
}
