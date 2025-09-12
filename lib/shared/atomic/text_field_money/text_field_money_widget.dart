import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class TextFieldMoneyWidget extends StatefulWidget {
  const TextFieldMoneyWidget({
    super.key,
    this.placeholder,
    this.maxLength,
    this.initialValue,
    required this.onChanged,
    this.value,
    this.borderless = false,
    this.onBlur,
  });

  final String? placeholder;
  final int? maxLength;
  final String? initialValue;
  final String? value;
  final void Function(String?) onChanged;
  final void Function(String?)? onBlur;
  final bool borderless;

  @override
  State<TextFieldMoneyWidget> createState() => _TextFieldMoneyWidgetState();
}

class _TextFieldMoneyWidgetState extends State<TextFieldMoneyWidget> {
  late final TextEditingController _controller;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        String numeric = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
        widget.onBlur?.call(numeric.isEmpty ? null : numeric);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TextFieldMoneyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _onChangeInput(widget.value ?? '');
    }
  }

  void _onChangeInput(String value) {
    String numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isEmpty) {
      return;
    }
    String formatted = convertToCurrency(numeric);
    _controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _onChangeText(String value) {
    String numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isEmpty) {
      _controller.text = '';
      widget.onChanged('');
      return;
    }

    widget.onChanged(numeric);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.borderless) {
      return CupertinoTextField.borderless(
        controller: _controller,
        focusNode: focusNode,
        textAlign: TextAlign.right,
        placeholder: widget.placeholder,
        maxLength: widget.maxLength,
        keyboardType: TextInputType.number,
        onChanged: (val) => _onChangeText(val),
        suffix: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text('₫'),
        ),
      );
    }
    return CupertinoTextField(
      controller: _controller,
      focusNode: focusNode,
      textAlign: TextAlign.right,
      placeholder: widget.placeholder,
      maxLength: widget.maxLength,
      keyboardType: TextInputType.number,
      onChanged: (val) => _onChangeText(val),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Text('₫'),
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
    );
  }
}
