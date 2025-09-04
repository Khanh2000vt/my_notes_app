import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/features/create_room/widget/card_member_room.dart';
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
                  header: const Text("Thông tin phòng"),
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
                      suffix: 'đ',
                    ),
                  ],
                ),
                CupertinoFormSection.insetGrouped(
                  header: const Text("Thành viên của phòng"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          10,
                          (index) => const CardMemberRoom(),
                        ),
                      ),
                    ),
                    CupertinoButton(
                      alignment: Alignment.center,
                      child: Text('Thêm thành viên'),
                      onPressed: () {},
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
