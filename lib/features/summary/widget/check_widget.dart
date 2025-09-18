import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/enums/category_expense.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    super.key,
    required this.summary,
    required this.group,
    required this.members,
    required this.amountByMember,
  });
  final ExpenseSummary summary;
  final bool group;
  final List<ExpenseMember> members;
  final num amountByMember;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                style: TextStyle(fontSize: 14),
              ),
            ),
            ...summary.byCategory.map((category) {
              return CupertinoListTile(
                title: Text(
                  CategoryExpense.labelFromValue(category.categoryId),
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
          children: members.isEmpty
              ? [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Không có dữ liệu'),
                    ),
                  ),
                ]
              : [
                  ...members.map((member) {
                    return CupertinoListTile(
                      leading: AvatarWidget(name: member.memberId.toString()),
                      title: Text(member.name),
                      additionalInfo: member.own == true
                          ? null
                          : Text(
                              '${convertToCurrency(member.amount.toString())} đ',
                              style: TextStyle(
                                color: group ? null : CupertinoColors.systemRed,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  }),
                  if (group)
                    CupertinoListTile(
                      title: Text(
                        'Tổng phải trả',
                        style: TextStyle(
                          color: CupertinoColors.systemBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      additionalInfo: Text(
                        '${convertToCurrency(amountByMember.toString())} đ',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
        ),
      ],
    );
  }
}
