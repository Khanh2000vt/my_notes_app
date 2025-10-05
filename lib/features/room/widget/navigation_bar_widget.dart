import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/interface/member.dart';
import 'package:my_notes_app/routing/routes.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({
    super.key,
    required this.members,
    required this.onAdd,
  });

  final List<Member>? members;
  final void Function() onAdd;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      leading: CupertinoNavigationBarBackButton(
        previousPageTitle: 'Trở lại',
        onPressed: () {
          context.pop();
        },
      ),
      largeTitle: Text('Phòng'),
      trailing: members == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(CupertinoIcons.chart_bar),
                  onPressed: () {
                    context.push(Routes.summaryExpense);
                  },
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onAdd,
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
    );
  }
}
