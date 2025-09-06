import 'package:flutter/cupertino.dart';

class ActionApp {
  const ActionApp._();

  static Future<T?> bottomSheet<T>({
    required BuildContext ctx,
    required Widget Function(BuildContext) child,
    double height = 250,
  }) async {
    return await showCupertinoModalPopup<T>(
      context: ctx,
      builder: (context) => Container(
        height: height,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child(context)),
      ),
    );
  }

  static void editActionSheet({
    required BuildContext context,
    String? title,
    String? message,
    required void Function() onEdit,
    required void Function() onRemove,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) {
        return CupertinoActionSheet(
          title: title == null ? null : Text(title),
          message: message == null ? null : Text(message),
          actions: [
            CupertinoActionSheetAction(onPressed: onEdit, child: Text('Sửa')),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: onRemove,
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
}
