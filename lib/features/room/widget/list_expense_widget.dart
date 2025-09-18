import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/enums/category_expense.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/expense_room.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class ListExpenseWidget extends StatelessWidget {
  const ListExpenseWidget({
    super.key,
    required this.futureExpense,
    required this.onTapExpense,
  });

  final Future<List<ExpenseRoom>?> futureExpense;
  final void Function(ExpenseRoom expenseRoom) onTapExpense;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExpenseRoom>?>(
      future: futureExpense,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Center(child: CupertinoActivityIndicator()),
            ),
          );
        }
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text("Không có khoản chi nào!")),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = snapshot.data![index];
            return CupertinoListTile(
              onTap: () => onTapExpense(item),
              title: Text(
                CategoryExpense.labelFromValue(item.category),
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(DateTimeFormat.dateToDate(item.date)),
              additionalInfo: Text(
                '${convertToCurrency(item.amount.toString())}đ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemRed,
                  fontSize: 13,
                ),
              ),
              trailing: const CupertinoListTileChevron(),
              leading: AvatarWidget(name: item.payerId.toString()),
              backgroundColor:
                  (index % 2 == 0
                          ? CupertinoColors.secondarySystemBackground
                          : CupertinoColors.systemBackground)
                      .resolveFrom(context),
            );
          }, childCount: snapshot.data?.length ?? 0),
        );
      },
    );
  }
}
