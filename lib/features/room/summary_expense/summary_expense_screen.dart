import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class SummaryExpenseScreen extends StatelessWidget {
  const SummaryExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Tổng kết'),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Trở lại',
          onPressed: () {
            context.pop();
          },
        ),
      ),
      child: const SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(),
      ),
    );
  }
}
