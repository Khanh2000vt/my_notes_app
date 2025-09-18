import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';

class ReminderDailyRoom extends StatelessWidget {
  const ReminderDailyRoom({super.key});

  Future<void> _onPressedTime(
    BuildContext ctx,
    FormFieldState<DateTime> field,
  ) async {
    DateTime selected = (field.value ?? DateTime.now());
    final result = await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => CupertinoPopupSurface(
        isSurfacePainted: true,
        child: Container(
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
                    child: Text('Chọn'),
                    onPressed: () {
                      Navigator.pop(context, selected);
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: selected,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime value) {
                    selected = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (result != null) {
      field.didChange(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<bool>(
      name: 'reminder_day',
      initialValue: false,
      builder: (fieldParent) => CupertinoFormSection.insetGrouped(
        footer: const Text(
          'Nhắc nhở bạn vào thời gian đã chọn để tổng kết lại chi tiêu trong ngày',
        ),
        children: [
          FormRowWidget(
            label: 'Tổng kết hàng ngày',
            child: CupertinoSwitch(
              value: fieldParent.value ?? false,
              onChanged: fieldParent.didChange,
              activeTrackColor: CupertinoColors.activeBlue,
            ),
          ),
          if (fieldParent.value == true)
            FormRowWidget(
              label: 'Thời gian',
              child: FormBuilderField<DateTime>(
                name: 'time_in_day',
                initialValue: DateTimeFormat.setTimeToDate(
                  DateTime.now(),
                  hour: 22,
                  minute: 0,
                ),
                builder: (field) => CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: CupertinoColors.systemGrey5.resolveFrom(context),
                  onPressed: () => _onPressedTime(context, field),
                  child: Text(
                    DateTimeFormat.dateToTime(field.value),
                    style: TextStyle(
                      color: CupertinoColors.label.resolveFrom(context),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
