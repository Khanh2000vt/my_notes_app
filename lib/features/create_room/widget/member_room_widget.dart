import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/features/create_room/widget/card_member_room.dart';

class MemberRoomWidget extends StatelessWidget {
  const MemberRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: const Text("THÀNH VIÊN"),
      footer: const Text('Nhấn vào thành viên để hiện các tùy chọn sửa, xóa'),
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
    );
  }
}
