import 'package:intl/intl.dart';

class HumanTimes {
  static String getDate(String timestamp) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp).round());

    return dateFormat.format(date);
  }
}
