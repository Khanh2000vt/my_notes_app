import 'package:flutter/cupertino.dart';

class FormRowWidget extends StatelessWidget {
  const FormRowWidget({
    super.key,
    required this.child,
    this.error,
    this.helper,
    this.prefix,
    this.label,
    this.padding,
  });

  final Widget child;
  final Widget? helper;
  final Widget? prefix;
  final String? label;
  final String? error;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      error: error == null ? null : Text(error!),
      helper: helper,
      padding: padding,
      prefix: prefix ?? (label != null ? Text(label!) : null),
      child: child,
    );
  }
}
