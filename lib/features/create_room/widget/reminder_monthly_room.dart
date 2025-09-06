import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';

class ReminderMonthlyRoom extends StatelessWidget {
  const ReminderMonthlyRoom({super.key});

  Future<void> _onPressedPicker(
    BuildContext ctx,
    FormFieldState<int> field,
  ) async {
    int selected = (field.value ?? 4);
    final result = await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => Container(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        height: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text('Huỷ'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoButton(
                  child: Text('Xong'),
                  onPressed: () {
                    Navigator.pop(context, selected);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                magnification: 1.22,
                looping: false,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32,
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (int value) {
                  selected = value;
                },
                children: List<Widget>.generate(28, (int index) {
                  return Center(child: Text('Ngày ${index + 1}'));
                }),
              ),
            ),
          ],
        ),
      ),
    );
    if (result != null) {
      field.didChange(result + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<bool>(
      name: 'reminder_monthly',
      initialValue: false,
      builder: (fieldParent) => CupertinoFormSection.insetGrouped(
        header: const Text("THÔNG BÁO"),
        footer: const Text('Chọn ngày để nhận thông báo tổng kết hàng tháng'),
        children: [
          FormRowWidget(
            label: 'Tổng kết hàng tháng',
            child: CupertinoSwitch(
              value: fieldParent.value ?? false,
              onChanged: fieldParent.didChange,
              activeTrackColor: CupertinoColors.activeBlue,
            ),
          ),
          if (fieldParent.value == true)
            FormRowWidget(
              label: 'Ngày thông báo',
              child: FormBuilderField<int>(
                name: 'day_in_month',
                initialValue: 4,
                builder: (field) => CupertinoButton(
                  onPressed: () => _onPressedPicker(context, field),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: CupertinoColors.systemGrey5.resolveFrom(context),
                  child: (Text(
                    'Ngày ${field.value ?? 1}',
                    style: TextStyle(
                      color: CupertinoColors.label.resolveFrom(context),
                    ),
                  )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
