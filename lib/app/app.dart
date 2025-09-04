// Cấu hình MaterialApp.router
import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/routing/router.dart';

class MyNotes extends StatelessWidget {
  const MyNotes({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: const CupertinoThemeData(brightness: Brightness.dark),
    );
  }
}
