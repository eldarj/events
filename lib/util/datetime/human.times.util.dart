import 'package:intl/intl.dart';

class HumanTimes {
  static String getDateString(String timestamp) {
    return getDate(int.parse(timestamp));
  }

  static String getDate(int timestamp) {
    final dateFormat = DateFormat('EEEE MMM. d');
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.round());

    return dateFormat.format(date);
  }
}
