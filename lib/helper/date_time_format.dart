import 'package:jiffy/jiffy.dart';

class DateTimeFormat {
  DateTimeFormat._();
  static String dateToTime(DateTime? date) {
    if (date == null) {
      return '--:--';
    }
    return Jiffy.parseFromDateTime(date).format(pattern: 'HH:mm');
  }

  static DateTime setTimeToDate(DateTime date, {int? hour, int? minute}) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      hour ?? date.hour,
      minute ?? date.minute,
    );
  }
}
