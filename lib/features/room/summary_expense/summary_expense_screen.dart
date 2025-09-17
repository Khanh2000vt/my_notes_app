import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/enums/category_expense.dart';
import 'package:my_notes_app/features/room/summary_expense/widget/config_export_widget.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:my_notes_app/services/expense.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/shared/molecular/modal_popup/modal_popup.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class SummaryExpenseScreen extends StatefulWidget {
  const SummaryExpenseScreen({super.key});

  @override
  State<SummaryExpenseScreen> createState() => _SummaryExpenseScreenState();
}

class _SummaryExpenseScreenState extends State<SummaryExpenseScreen> {
  DateTime selectedDate = DateTime.now();
  ExpenseSummary summary = ExpenseSummary(
    byCategory: [],
    expenseMember: [],
    total: 0,
  );
  bool fetching = true;
  bool group = false;
  List<ExpenseMember> members = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      setState(() {
        fetching = true;
      });
      final res = await ExpenseService().fetchRoomExpenseSummary(
        selectedDate,
        1,
      );
      setState(() {
        summary = res;
        members = summary.expenseMember;
        fetching = false;
      });
    } catch (e) {
      setState(() {
        summary = ExpenseSummary(byCategory: [], expenseMember: [], total: 0);
        fetching = false;
        members = [];
      });
    }
  }

  Future<void> _onPickerMember(BuildContext ctx) async {
    final result = await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => ConfigExportWidget(
        expenseMember: summary.expenseMember,
        context: context,
        group: group,
        members: members,
        selectedDate: selectedDate,
      ),
    );
    if (result != null) {
      setState(() {
        group = result['group'] as bool;
        members = result['members'] as List<ExpenseMember>;
        selectedDate = result['selectedDate'] as DateTime;
      });
    }
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
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.ellipsis_vertical_circle),
          onPressed: () {
            _onPickerMember(context);
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Text(DateTimeFormat.formatMonthYear(selectedDate)),
            Expanded(
              child: fetching
                  ? CupertinoActivityIndicator()
                  : SingleChildScrollView(
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
                                  '${convertToCurrency(summary.total.toString())} đ',
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
                                                color:
                                                    CupertinoColors.systemRed,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    );
                                  }).toList(),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CupertinoButton.filled(
                  onPressed: fetching
                      ? null
                      : () {
                          ModalPopupApp.modalPopup(
                            ctx: context,
                            initValue: null,
                            child: (context, onChanged) {
                              return Center(
                                child: Text('Chức năng đang phát triển'),
                              );
                            },
                          );
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [Icon(CupertinoIcons.share), Text('Chia sẻ')],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
