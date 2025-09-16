import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/features/room/room/widget/list_member_widget.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/room.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class HeaderStickyWidget extends StatelessWidget {
  const HeaderStickyWidget({
    super.key,
    required this.room,
    required this.selectedDate,
    required this.onSelectedDate,
  });

  final Room? room;
  final DateTime selectedDate;
  final void Function(DateTime date) onSelectedDate;

  Future<void> _onPressedTime(BuildContext ctx) async {
    DateTime selected = selectedDate;
    final result = await showCupertinoModalPopup<DateTime>(
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
                  mode: CupertinoDatePickerMode.monthYear,
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
    if (result != null && result != selectedDate) {
      onSelectedDate(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return room == null
        ? SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 6,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room?.name ?? '_',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tiền thuê: ${convertToCurrency(room?.priceRoom.toString())}đ',
                          style: TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                    ListMemberWidget(members: room?.members ?? []),
                  ],
                ),
                CupertinoButton(
                  child: Text(DateTimeFormat.formatMonthYear(selectedDate)),
                  onPressed: () => _onPressedTime(context),
                ),
              ],
            ),
          );
  }
}
