import 'package:flutter/cupertino.dart';

class CardFixedAmountRoom extends StatelessWidget {
  const CardFixedAmountRoom({super.key});

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: Text('Tiền thang máy'),
          message: Text('500.000đ'),
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
      child: CupertinoFormRow(
        padding: EdgeInsets.zero,
        prefix: Text('Tiền thang máy'),
        child: Text(
          '500.000₫',
          style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
        ),
      ),
      onPressed: () => _showActionSheet(context),
    );
  }
}
