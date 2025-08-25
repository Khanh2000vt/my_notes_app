import 'package:flutter/material.dart';
import 'package:my_notes_app/core/constants/exports.dart';
import 'package:my_notes_app/routing/router.dart';
import 'package:my_notes_app/shared/molecular/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonAppElevated(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove(StorageConstants.authToken);
            authToken.value = null;
          },
          label: 'Logout',
        ),
      ),
    );
  }
}
