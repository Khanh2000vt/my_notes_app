// Cấu hình MaterialApp.router
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import 'app_router.dart';
import 'app_theme.dart';

class MyNotes extends StatelessWidget {
  const MyNotes({super.key});
  @override
  Widget build(BuildContext context) {
    final combinedTheme = MixThemeData.withMaterial().merge(lightBlueTheme);
    return MixTheme(
      data: combinedTheme,
      child: MaterialApp.router(
        title: 'My Notes',
        debugShowCheckedModeBanner: false,
        routerConfig: routers,
      ),
    );
  }
}
