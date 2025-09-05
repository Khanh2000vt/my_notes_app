import 'package:flutter/cupertino.dart';

class PrefixIconWidget extends StatelessWidget {
  const PrefixIconWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Icon(icon, color: CupertinoColors.white),
        ),
        const SizedBox(width: 15),
        Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
