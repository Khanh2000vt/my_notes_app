import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_notes_app/helper/notification.dart';
import 'package:my_notes_app/routing/router.dart';
import 'package:my_notes_app/utils/string_handle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;

import 'app/app.dart';

Future<void> main() async {
  IOSFlutterLocalNotificationsPlugin.registerWith();
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_KEY'] ?? '',
  );
  tzl.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  await NotificationApp().cancelAll();
  await NotificationApp().runNotification();
  await initializeAuthToken();
  runApp(const MyApp());
}

Future<void> initializeAuthToken() async {
  final userId = await getUserId();
  authToken.value = userId?.toString();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MyNotes();
  }
}
