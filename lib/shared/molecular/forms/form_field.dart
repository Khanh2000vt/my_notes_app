import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:my_notes_app/shared/atomic/text_field_money/text_field_money_widget.dart';

class FieldApp {
  const FieldApp._();

  static Widget _buildField<T>({
    required String name,
    T? initialValue,
    FormFieldValidator<T>? validator,
    required Widget Function(FormFieldState<T>) builder,
  }) {
    return FormBuilderField<T>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      builder: builder,
    );
  }

  static Widget input({
    required String name,
    String? initialValue,
    FormFieldValidator<String>? validator,
    String? placeholder,
    int? maxLength,
  }) {
    return _buildField<String>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (field) {
        return CupertinoTextField.borderless(
          textAlign: TextAlign.right,
          placeholder: placeholder,
          maxLength: maxLength,
          onChanged: field.didChange,
        );
      },
    );
  }

  static Widget money({
    required String name,
    String? initialValue,
    FormFieldValidator<String>? validator,
    String? placeholder,
    int? maxLength,
  }) {
    return _buildField<String>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (field) => TextFieldMoneyWidget(
        onChanged: field.didChange,
        placeholder: placeholder,
        maxLength: maxLength,
        initialValue: initialValue,
      ),
    );
  }

  static Widget select({
    required String name,
    required List<Widget> children,
    int? initialValue,
    FormFieldValidator<int>? validator,
    bool? looping,
  }) {
    return _buildField<int>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (field) => CupertinoPicker(
        magnification: 1.22,
        looping: looping ?? false,
        squeeze: 1.2,
        useMagnifier: true,
        itemExtent: 32,
        scrollController: FixedExtentScrollController(
          initialItem: field.value ?? 0,
        ),
        onSelectedItemChanged: field.didChange,
        children: children,
      ),
    );
  }

  static Widget date({
    required String name,
    DateTime? initialValue,
    FormFieldValidator<DateTime>? validator,
    CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
    DateTime? minimumDate,
    DateTime? maximumDate,
    bool use24hFormat = true,
    Duration minuteInterval = const Duration(minutes: 1),
  }) {
    return _buildField<DateTime>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (field) => CupertinoDatePicker(
        mode: mode,
        initialDateTime: field.value ?? DateTime.now(),
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        use24hFormat: use24hFormat,
        minuteInterval: minuteInterval.inMinutes,
        onDateTimeChanged: field.didChange,
      ),
    );
  }

  static Widget switchField({
    required String name,
    bool initialValue = false,
    FormFieldValidator<bool>? validator,
  }) {
    return _buildField<bool>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (field) => CupertinoSwitch(
        value: field.value ?? false,
        onChanged: field.didChange,
        activeTrackColor: CupertinoColors.activeBlue,
      ),
    );
  }
}
