// Cấu hình MaterialApp.router
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_notes_app/routing/router.dart';

class MyNotes extends StatelessWidget {
  const MyNotes({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi', '')],
      locale: const Locale('vi', ''),
      theme: const CupertinoThemeData(brightness: Brightness.dark),
    );
  }
}
