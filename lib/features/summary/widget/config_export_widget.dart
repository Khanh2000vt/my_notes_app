import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';

class ConfigExportWidget extends StatefulWidget {
  const ConfigExportWidget({
    super.key,
    required this.expenseMember,
    required this.context,
    required this.group,
    required this.members,
    required this.selectedDate,
  });

  final List<ExpenseMember> expenseMember;
  final BuildContext context;
  final bool group;
  final List<ExpenseMember> members;
  final DateTime selectedDate;

  @override
  State<ConfigExportWidget> createState() => _ConfigExportWidgetState();
}

class _ConfigExportWidgetState extends State<ConfigExportWidget> {
  bool group = false;
  List<ExpenseMember> members = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      members = widget.members;
      group = widget.group;
      selectedDate = widget.selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      isSurfacePainted: true,
      child: Container(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.chevron_back),
                        Text('Huỷ'),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: Text('Lưu'),
                    onPressed: () {
                      Navigator.pop(context, {
                        'group': group,
                        'members': members,
                        'selectedDate': selectedDate,
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CupertinoFormSection.insetGrouped(
                        header: Text('NHÓM TIỀN THEO'),
                        footer: Text(
                          'Số tiền sẽ được gộp lại theo các thành viên đã chọn',
                        ),
                        children: [
                          CupertinoFormRow(
                            prefix: Text('Gộp tổng theo nhóm'),
                            child: CupertinoSwitch(
                              value: group,
                              onChanged: (value) {
                                setState(() {
                                  group = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      CupertinoFormSection.insetGrouped(
                        header: Text('CHỌN THÀNH VIÊN'),
                        children: widget.expenseMember.map((member) {
                          final isSelected = members.any(
                            (m) => m.memberId == member.memberId,
                          );
                          return CupertinoFormRow(
                            prefix: Row(
                              spacing: 10,
                              children: [
                                AvatarWidget(name: member.name),
                                Text(member.name),
                              ],
                            ),
                            child: CupertinoSwitch(
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (isSelected) {
                                    members = members
                                        .where(
                                          (m) => m.memberId != member.memberId,
                                        )
                                        .toList();
                                  } else {
                                    members = [...members, member];
                                  }
                                  // if (isSelected) {
                                  //   members.removeWhere(
                                  //     (m) => m.memberId == member.memberId,
                                  //   );
                                  // } else {
                                  //   members.add(member);
                                  // }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      CupertinoFormSection.insetGrouped(
                        header: Text('CHỌN THỜI GIAN'),
                        children: [
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.monthYear,
                              initialDateTime: selectedDate,
                              maximumDate: DateTime.now(),
                              onDateTimeChanged: (DateTime dateTime) {
                                selectedDate = dateTime;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
