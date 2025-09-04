import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardMemberRoom extends StatelessWidget {
  const CardMemberRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          trailingIcon: CupertinoIcons.pencil,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Sửa'),
        ),
        CupertinoContextMenuAction(
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Xóa'),
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.darkBackgroundGray,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(radius: 20),
            SizedBox(height: 10),
            Text(
              'Nguyễn Ngọc Khánh',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
