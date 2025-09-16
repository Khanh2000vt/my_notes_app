import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/interface/member.dart';
import 'package:my_notes_app/routing/routes.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key, required this.members});

  final List<Member>? members;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      leading: CupertinoNavigationBarBackButton(
        previousPageTitle: 'Trở lại',
        onPressed: () {
          context.pop();
        },
      ),
      largeTitle: Text('Home'),
      trailing: members == null
          ? null
          : CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.add),
              onPressed: () {
                context.push(Routes.addExpense, extra: members);
              },
            ),
    );
  }
}
