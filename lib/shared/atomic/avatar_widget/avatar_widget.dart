import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_notes_app/helper/debounce.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({super.key, required this.name, this.radius = 16});

  final String name;
  final double radius;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  late final Debounce _debounce;
  String? _debouncedName;

  @override
  void initState() {
    super.initState();
    _debounce = Debounce();
    _setDebouncedName(widget.name);
  }

  @override
  void didUpdateWidget(covariant AvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      _setDebouncedName(widget.name);
    }
  }

  void _setDebouncedName(String newName) {
    _debounce.run(() {
      if (mounted) {
        setState(() => _debouncedName = newName);
      }
    });
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.radius * 2;
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: CupertinoColors.inactiveGray,
      child: ClipOval(
        child: Image.network(
          (_debouncedName != null && _debouncedName != '')
              ? 'https://api.dicebear.com/9.x/thumbs/png?seed=$_debouncedName'
              : '',
          width: size,
          height: size,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            print('loadingProgress: $loadingProgress');
            if (loadingProgress == null) return child;
            return Center(
              child: CupertinoActivityIndicator(
                radius: widget.radius / 3,
                color: CupertinoColors.secondarySystemFill,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: size,
              height: size,
              color: CupertinoColors.inactiveGray,
            );
          },
        ),
      ),
    );
  }
}
