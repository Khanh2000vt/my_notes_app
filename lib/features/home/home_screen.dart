import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Trang chủ')),
      child: SafeArea(
        child: CupertinoListSection(
          header: const Text('CHỨC NĂNG'),
          children: [
            CupertinoListTile(
              title: Text('Phòng trọ'),
              leading: Icon(CupertinoIcons.home),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                context.push(Routes.room);
              },
            ),
            CupertinoListTile(
              title: Text('Chi tiêu cá nhân'),
              leading: Icon(CupertinoIcons.person),
              trailing: const CupertinoListTileChevron(),
            ),
          ],
        ),
      ),
    );
  }
}
