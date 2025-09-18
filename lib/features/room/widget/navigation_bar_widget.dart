import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/interface/member.dart';
import 'package:my_notes_app/routing/routes.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({
    super.key,
    required this.members,
    required this.onRefresh,
  });

  final List<Member>? members;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      leading: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text('Tổng kết'),
        onPressed: () {
          context.push(Routes.summaryExpense);
        },
      ),
      largeTitle: Text('Phòng'),
      trailing: members == null
          ? null
          : CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(' Thêm khoản'),
              onPressed: () {
                context.push(Routes.expense, extra: members).then((value) {
                  onRefresh();
                });
              },
            ),
    );
  }
}
