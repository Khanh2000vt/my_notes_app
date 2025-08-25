import 'package:flutter/material.dart';
import 'package:my_notes_app/routing/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/constants/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAuthToken();
  runApp(const MyApp());
}

Future<void> initializeAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(StorageConstants.authToken);
  authToken.value = token;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MyNotes();
  }
}
