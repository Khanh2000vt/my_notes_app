import 'package:flutter/material.dart';
import 'package:my_notes_app/core/constants/storage_constants.dart';
import 'package:my_notes_app/routing/router.dart';
import 'package:my_notes_app/shared/molecular/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: ButtonAppFilled(
        label: 'Test Button',
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(StorageConstants.authToken, 'abc');
          authToken.value = 'abc';
        },
      ),
    );
  }
}
