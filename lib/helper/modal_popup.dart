import 'package:flutter/cupertino.dart';

final class ModalPopupApp {
  void showModalPopup({
    required BuildContext ctx,
    required Widget child,
    double height = 250,
  }) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) => Container(
        height: height,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(top: false, child: child),
      ),
    );
  }
}
