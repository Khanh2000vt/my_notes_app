import 'package:timezone/timezone.dart' as tz;

tz.TZDateTime nextInstanceOfTenPM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    22,
  );

  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime nextInstanceOfBirthday({required int day, required int month}) {
  final now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    month,
    day,
    9,
  );
  if (scheduledDate.isBefore(now)) {
    scheduledDate = tz.TZDateTime(tz.local, now.year + 1, month, day, 9);
  }
  return scheduledDate;
}

tz.TZDateTime nextInstanceOfBirthdayBefore1Week({
  required int day,
  required int month,
}) {
  final now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    now.year,
    month,
    day,
    9,
  ).subtract(const Duration(days: 7));

  if (scheduledDate.isBefore(now)) {
    scheduledDate = tz.TZDateTime(
      tz.local,
      now.year + 1,
      month,
      day,
      9,
    ).subtract(const Duration(days: 7));
  }

  return scheduledDate;
}
