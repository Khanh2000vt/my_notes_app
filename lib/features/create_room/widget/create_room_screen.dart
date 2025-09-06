import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/create_room/widget/fixed_amount_room_widget.dart';
import 'package:my_notes_app/features/create_room/widget/member_room_widget.dart';
import 'package:my_notes_app/features/create_room/widget/reminder_daily_room.dart';
import 'package:my_notes_app/features/create_room/widget/reminder_monthly_room.dart';
import 'package:my_notes_app/features/create_room/widget/room_information_widget.dart';

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({super.key});
  final GlobalKey _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Tạo phòng'),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Trở lại',
          onPressed: () {
            context.pop();
          },
        ),
        trailing: Text('Xong'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                RoomInformationWidget(),
                MemberRoomWidget(),
                FixedAmountRoomWidget(),
                ReminderMonthlyRoom(),
                ReminderDailyRoom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
