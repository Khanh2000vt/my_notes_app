import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/enums/category_expense.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:my_notes_app/services/expense.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class SummaryExpenseScreen extends StatefulWidget {
  const SummaryExpenseScreen({super.key});

  @override
  State<SummaryExpenseScreen> createState() => _SummaryExpenseScreenState();
}

class _SummaryExpenseScreenState extends State<SummaryExpenseScreen> {
  DateTime selectedDate = DateTime.now();
  late Future<ExpenseSummary> _futureExpenseSummary;

  @override
  void initState() {
    super.initState();
    _futureExpenseSummary = ExpenseService().fetchRoomExpenseSummary(
      DateTime.now(),
      '027bd95f-e964-4589-98a7-981990fcc9d0',
    );
  }

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
      child: FutureBuilder<ExpenseSummary>(
        future: _futureExpenseSummary,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }
          final summary =
              snapshot.data ??
              ExpenseSummary(byCategory: [], expenseMember: [], total: 0);

          final totalAll = summary.total;
          return SafeArea(
            child: Column(
              children: [
                CupertinoButton(
                  child: Text(DateTimeFormat.formatMonthYear(selectedDate)),
                  onPressed: () {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        CupertinoFormSection.insetGrouped(
                          header: Text('CHI TIÊU THEO DANH MỤC'),
                          children: [
                            CupertinoListTile(
                              title: Text(
                                'Tổng',
                                style: TextStyle(
                                  color: CupertinoColors.systemBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              additionalInfo: Text(
                                '${convertToCurrency(totalAll.toString())} đ',
                                style: TextStyle(
                                  color: CupertinoColors.systemRed,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            CupertinoListTile(
                              title: Text('Tiền nhà'),
                              additionalInfo: Text(
                                '5.500.000 đ',
                                style: TextStyle(
                                  color: CupertinoColors.systemRed,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            ...summary.byCategory.map((category) {
                              return CupertinoListTile(
                                title: Text(
                                  CategoryExpense.labelFromValue(
                                    category.categoryId,
                                  ),
                                ),
                                additionalInfo: Text(
                                  '${convertToCurrency(category.amount.toString())} đ',
                                  style: TextStyle(
                                    color: CupertinoColors.systemRed,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        CupertinoFormSection.insetGrouped(
                          header: Text('SỐ TIỀN PHẢI TRẢ THEO THÀNH VIÊN'),
                          children: summary.expenseMember.isEmpty
                              ? [
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Không có dữ liệu'),
                                    ),
                                  ),
                                ]
                              : summary.expenseMember.map((member) {
                                  return CupertinoListTile(
                                    leading: AvatarWidget(
                                      name: member.memberId.toString(),
                                    ),
                                    title: Text(member.name),
                                    additionalInfo: member.own == true
                                        ? null
                                        : Text(
                                            '${convertToCurrency(member.amount.toString())} đ',
                                            style: TextStyle(
                                              color: CupertinoColors.systemRed,
                                              fontSize: 14,
                                            ),
                                          ),
                                  );
                                }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                CupertinoButton.filled(
                  child: Text('Chia sẻ'),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
