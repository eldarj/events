import 'package:intl/intl.dart';

class HumanTimes {
  static String getDate(String timestamp) {
    final dateFormat = DateFormat('EEEE MMM. d');
    final date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp).round());

    return dateFormat.format(date);
  }
}
