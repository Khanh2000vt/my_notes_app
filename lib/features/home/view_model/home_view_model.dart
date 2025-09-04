import 'package:flutter/cupertino.dart';

class ItemFeature {
  final String title;
  final IconData leading;
  final IconData trailing;
  final VoidCallback onTap;

  ItemFeature({
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
  });
}

class HomeViewModel {
  final List<ItemFeature> items = [
    ItemFeature(
      title: "Profile",
      leading: CupertinoIcons.person,
      trailing: CupertinoIcons.forward,
      onTap: () {
        debugPrint("Profile tapped");
      },
    ),
    ItemFeature(
      title: "Notifications",
      leading: CupertinoIcons.bell,
      trailing: CupertinoIcons.forward,
      onTap: () {
        debugPrint("Notifications tapped");
      },
    ),
    ItemFeature(
      title: "Settings",
      leading: CupertinoIcons.settings,
      trailing: CupertinoIcons.forward,
      onTap: () {
        debugPrint("Settings tapped");
      },
    ),
  ];
}
