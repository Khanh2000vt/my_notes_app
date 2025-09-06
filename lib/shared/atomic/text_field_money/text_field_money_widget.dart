import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TextFieldMoneyWidget extends StatefulWidget {
  const TextFieldMoneyWidget({
    super.key,
    this.placeholder,
    this.maxLength,
    this.initialValue,
    required this.onChanged,
  });

  final String? placeholder;
  final int? maxLength;
  final String? initialValue;
  final void Function(String?) onChanged;

  @override
  State<TextFieldMoneyWidget> createState() => _TextFieldMoneyWidgetState();
}

class _TextFieldMoneyWidgetState extends State<TextFieldMoneyWidget> {
  late final TextEditingController _controller;
  final _formatter = NumberFormat("#,###", "vi_VN");

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChangeText(String value) {
    String numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isEmpty) {
      _controller.text = '';
      widget.onChanged('');
      return;
    }
    String formatted = _formatter.format(int.parse(numeric));
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    widget.onChanged(numeric);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField.borderless(
      controller: _controller,
      textAlign: TextAlign.right,
      placeholder: widget.placeholder,
      maxLength: widget.maxLength,
      keyboardType: TextInputType.number,
      onChanged: (val) => _onChangeText(val),
      suffix: Text('₫'),
    );
  }
}
