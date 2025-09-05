import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/create_room/widget/card_fixed_amount_room.dart';
import 'package:my_notes_app/features/create_room/widget/card_member_room.dart';
import 'package:my_notes_app/helper/modal_popup.dart';
import 'package:my_notes_app/shared/atomic/text_field_row_app/text_field_row_app.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
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
            key: formKey,
            child: Column(
              children: [
                CupertinoFormSection.insetGrouped(
                  header: const Text("PHÒNG"),
                  children: [
                    TextFieldRowApp(
                      name: 'name',
                      placeholder: "Nhập tên phòng",
                      maxLength: 100,
                      label: "Tên phòng",
                    ),
                    TextFieldRowApp(
                      name: 'price_room',
                      placeholder: "Số tiền thuê phòng",
                      maxLength: 100,
                      label: 'Tiền thuê',
                      keyboardType: TextInputType.number,
                      suffix: '₫',
                    ),
                  ],
                ),
                CupertinoFormSection.insetGrouped(
                  header: const Text("THÀNH VIÊN"),
                  footer: const Text(
                    'Nhấn vào thành viên để hiện các tùy chọn sửa, xóa',
                  ),
                  children: [
                    SizedBox(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return CardMemberRoom();
                          },
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: CupertinoButton(
                        child: Text('Thêm thành viên'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                CupertinoFormSection.insetGrouped(
                  header: const Text("CÁC KHOẢN CỐ ĐỊNH"),
                  footer: const Text(
                    'Nhấn vào khoản cố định để hiện các tùy chọn sửa, xóa',
                  ),
                  children: [
                    CardFixedAmountRoom(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CupertinoButton(
                        child: Text('Thêm khoản cố định'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                CupertinoFormSection.insetGrouped(
                  header: const Text("THÔNG BÁO"),
                  children: [
                    CupertinoFormRow(
                      prefix: Text('Tổng kết hàng tháng'),
                      child: CupertinoSwitch(
                        value: true,
                        activeTrackColor: CupertinoColors.activeBlue,
                        onChanged: (bool? value) {},
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: Text('Thời gian'),
                      child: CupertinoButton(
                        onPressed: () {
                          ModalPopupApp().showModalPopup(
                            ctx: context,
                            child: CupertinoPicker(
                              magnification: 1.22,
                              looping: true,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32,
                              scrollController: FixedExtentScrollController(
                                initialItem: 0,
                              ),
                              onSelectedItemChanged: (int selectedItem) {},
                              children: List<Widget>.generate(31, (int index) {
                                return Center(child: Text('Ngày ${index + 1}'));
                              }),
                            ),
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        color: CupertinoColors.systemGrey5.resolveFrom(context),
                        child: (Text(
                          'Ngày 05 hàng tháng',
                          style: TextStyle(
                            color: CupertinoColors.label.resolveFrom(context),
                          ),
                        )),
                      ),
                    ),
                    CupertinoFormRow(
                      child: CupertinoButton(
                        onPressed: () {
                          ModalPopupApp().showModalPopup(
                            ctx: context,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              use24hFormat: true,
                              onDateTimeChanged: (value) {},
                            ),
                          );
                        },
                        child: Text('Giờ'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
