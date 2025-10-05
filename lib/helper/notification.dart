import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_notes_app/core/constants/member_birthday.dart';
import 'package:my_notes_app/helper/time_notification.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApp {
  late final FlutterLocalNotificationsPlugin notification;

  NotificationApp() {
    notification = FlutterLocalNotificationsPlugin();
  }

  Future<void> showTestNotification() async {
    const iosDetails = DarwinNotificationDetails(
      sound: 'notify.aiff',
      presentSound: true,
    );
    const platformDetails = NotificationDetails(iOS: iosDetails);
    await notification.show(
      999,
      'Test thông báo 🔔',
      'Đây là thông báo test âm thanh tuỳ chỉnh',
      platformDetails,
    );
  }

  Future<void> cancelAll() async {
    await notification.cancelAll();
  }

  Future<void> runNotification() async {
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    await notification.initialize(
      InitializationSettings(iOS: initializationSettingsDarwin),
    );
    scheduleDailyTenPMNotificationSimple();
    notificationListBirthday();
  }

  Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    required tz.TZDateTime scheduledDate,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notify.aiff',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iosDetails,
    );
    await notification.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }

  void scheduleDailyTenPMNotificationSimple() {
    showNotification(
      id: 100,
      title: 'Cập nhật chi tiêu',
      body: 'Cập nhật tiền chi tiêu hôm nay nào!',
      scheduledDate: nextInstanceOfTenPM(),
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void notificationListBirthday() {
    for (var member in memberBirthdays) {
      scheduleBirthdayNotification(
        notifId: member.id,
        name: member.name,
        day: member.day,
        month: member.month,
      );
    }
  }

  Future<void> scheduleBirthdayNotification({
    required int notifId,
    required String name,
    required int day,
    required int month,
  }) async {
    showNotification(
      id: notifId,
      title: 'Sắp đến sinh nhật của $name',
      body: 'Đừng quên gửi lời chúc mừng nhé!',
      scheduledDate: nextInstanceOfBirthdayBefore1Week(day: day, month: month),
    );
    showNotification(
      id: notifId + 10,
      title: 'Hôm nay là sinh nhật của $name',
      body: 'Đừng quên gửi lời chúc mừng nhé!',
      scheduledDate: nextInstanceOfBirthday(day: day, month: month),
    );
  }
}
