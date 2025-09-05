import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardMemberRoom extends StatelessWidget {
  const CardMemberRoom({super.key});
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: Text('Nguyễn Ngọc Khánh'),
          actions: [
            CupertinoActionSheetAction(child: Text('Sửa'), onPressed: () {}),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {},
              child: Text('Xoá'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(ctx, null);
            },
            child: Text('Huỷ'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      padding: EdgeInsets.zero,
      onPressed: () => _showActionSheet(context),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: CupertinoColors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: CupertinoColors.activeBlue,
              ),
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
      ),
    );
  }
}
