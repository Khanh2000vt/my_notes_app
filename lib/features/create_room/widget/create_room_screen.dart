import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/create_room/widget/fixed_amount_room_widget.dart';
import 'package:my_notes_app/features/create_room/widget/member_room_widget.dart';
import 'package:my_notes_app/features/create_room/widget/reminder_daily_room.dart';
import 'package:my_notes_app/features/create_room/widget/reminder_monthly_room.dart';
import 'package:my_notes_app/features/create_room/widget/room_information_widget.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isFormValid = false;

  void _onChanged() {
    final formState = _formKey.currentState;
    if (formState == null) return;

    // Kiểm tra tất cả các field có valid hay không
    final isValid = formState.fields.values.every((field) => field.isValid);

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Tạo phòng'),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Trở lại',
          onPressed: () {
            context.pop();
          },
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isFormValid
              ? () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final formData = _formKey.currentState?.value;
                    // Handle form submission logic here
                    print(formData);
                  } else {
                    print("Validation failed");
                  }
                }
              : null,
          child: Text('Tạo'),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: FormBuilder(
            key: _formKey,
            onChanged: _onChanged,
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
