import 'package:flutter/material.dart';
import 'package:my_notes_app/interface/member.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';

class ListMemberWidget extends StatelessWidget {
  const ListMemberWidget({super.key, required this.members});

  final int maxDisplay = 5;
  final double size = 28;
  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    final displayCount = members.length > maxDisplay
        ? maxDisplay - 1
        : members.length;
    final extraCount = members.length > maxDisplay
        ? members.length - (maxDisplay - 1)
        : 0;
    return SizedBox(
      height: size,
      width: size + (displayCount - 1) * (size * 0.6),
      child: Stack(
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: i * (size * 0.6),
              child: AvatarWidget(radius: size / 2, name: members[i].name),
            ),
          if (extraCount > 0)
            Positioned(
              left: (maxDisplay - 1) * (size * 0.6),
              child: CircleAvatar(
                radius: size / 2,
                backgroundColor: Colors.grey.shade400,
                child: Text(
                  '+$extraCount',
                  style: TextStyle(fontSize: size * 0.35, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
