import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:my_notes_app/core/design_system/exports.dart';
import 'app/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final combinedTheme = MixThemeData.withMaterial().merge(lightBlueTheme);
    return MixTheme(
      data: combinedTheme,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text('Flutter Demo Home Page')),
          body: Builder(
            builder: (context) => ButtonCustom(
              label: 'Test Button',
              onPressed: () {},
              variant: ButtonVariant.filled,
            ),
          ),
        ),
      ),
    );
  }
}
