import 'package:jiffy/jiffy.dart';

class DateTimeFormat {
  DateTimeFormat._();
  static String dateToTime(DateTime? date) {
    if (date == null) {
      return '--:--';
    }
    return Jiffy.parseFromDateTime(date).format(pattern: 'HH:mm');
  }
}
