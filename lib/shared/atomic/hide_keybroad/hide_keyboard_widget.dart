import 'package:flutter/cupertino.dart';

class HideKeyboardWidget extends StatelessWidget {
  const HideKeyboardWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
