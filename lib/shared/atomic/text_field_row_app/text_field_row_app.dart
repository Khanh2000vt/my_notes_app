import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class TextFieldRowApp extends StatefulWidget {
  const TextFieldRowApp({
    super.key,
    required this.name,
    required this.label,
    this.placeholder,
    this.maxLength,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.suffix,
  });

  final String name;
  final String label;
  final String? placeholder;
  final int? maxLength;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? suffix;

  @override
  State<TextFieldRowApp> createState() => _TextFieldRowAppState();
}

class _TextFieldRowAppState extends State<TextFieldRowApp> {
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

  void _onChangeText(String value, FormFieldState<String> field) {
    final isPrice = widget.keyboardType == TextInputType.number;
    if (isPrice) {
      String numeric = value.replaceAll(RegExp(r'[^0-9]'), '');
      if (numeric.isEmpty) {
        _controller.text = '';
        field.didChange('');
        return;
      }

      String formatted = _formatter.format(int.parse(numeric));
      _controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );

      // Trả về giá trị số gốc (ko format)
      field.didChange(numeric);

      return;
    }
    field.didChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (field) {
        return CupertinoFormRow(
          prefix: Text(widget.label),
          error: (field.errorText == null) ? null : Text(field.errorText!),
          child: CupertinoTextField.borderless(
            controller: _controller,
            textAlign: TextAlign.right,
            placeholder: widget.placeholder,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            onChanged: (val) => _onChangeText(val, field),
            suffix: Text(widget.suffix ?? ''),
          ),
        );
      },
    );
  }
}
