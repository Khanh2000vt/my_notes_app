import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/enums/category_expense.dart';
import 'package:my_notes_app/features/expense/model/expense_form_model.dart';
import 'package:my_notes_app/features/expense/model/expense_model.dart';
import 'package:my_notes_app/interface/member.dart';
import 'package:my_notes_app/services/expense.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';
import 'package:my_notes_app/shared/atomic/hide_keybroad/hide_keyboard_widget.dart';
import 'package:my_notes_app/shared/atomic/text_field_money/text_field_money_widget.dart';
import 'package:my_notes_app/shared/molecular/modal_popup/modal_popup.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, required this.model});
  final ExpenseModel model;

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final categories = CategoryExpense.values;
  bool _isFormValid = false;
  String amount = '';
  Map<String, dynamic> initialData = {};

  @override
  initState() {
    super.initState();
    setState(() {
      amount = widget.model.expense?.amount.toString() ?? '';
      _isFormValid = widget.model.expense != null;
    });
  }

  Future<void> _onSave({bool? isSave}) async {
    final formState = _formKey.currentState;
    if (formState == null) {
      return;
    }
    if (formState.saveAndValidate()) {
      final formData = formState.value;
      final expense = widget.model.expense;
      ExpenseService().upsertExpenseRoom(
        ExpenseFormModel(
          id: expense?.id,
          category: formData['category'] as int,
          price: formData['price'] as String,
          date: formData['date'],
          payer: formData['payer'] as int,
          members: List<int>.from(formData['members'] as List<dynamic>),
        ),
      );
      if (isSave == true) {
        if (!mounted) return;
        context.pop();
      } else {
        formState.reset();
        setState(() {
          _isFormValid = false;
          amount = '';
        });
      }
    }
  }

  void _onChanged() {
    final formState = _formKey.currentState;
    if (formState == null) return;
    final isValid = formState.fields.values.every((field) => field.isValid);

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboardWidget(
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Khoản chi'),
          leading: CupertinoNavigationBarBackButton(
            previousPageTitle: 'Trở lại',
            onPressed: () {
              context.pop();
            },
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: FormBuilder(
                    key: _formKey,
                    onChanged: _onChanged,
                    child: Column(
                      children: [
                        CupertinoFormSection.insetGrouped(
                          header: Text('Chi tiết'),
                          children: [
                            FormBuilderField<int>(
                              name: 'category',
                              initialValue: widget.model.expense?.category ?? 0,
                              validator: FormBuilderValidators.required(),
                              builder: (field) => FormRowWidget(
                                label: 'Loại tiền',

                                error: field.errorText,
                                child: CupertinoButton(
                                  pressedOpacity: 0.8,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    categories[field.value ?? 0].label,
                                  ),
                                  onPressed: () {
                                    ModalPopupApp.select(
                                      context: context,
                                      value: field.value ?? 0,
                                      onChanged: field.didChange,
                                      items: categories
                                          .map(
                                            (e) => Center(
                                              child: Text(
                                                e.label,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            FormBuilderField<String>(
                              name: 'price',
                              initialValue:
                                  widget.model.expense?.amount.toString() ?? '',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.integer(),
                                FormBuilderValidators.positiveNumber(),
                              ]),
                              builder: (field) {
                                return FormRowWidget(
                                  label: 'Tiền',
                                  error: field.errorText,
                                  child: TextFieldMoneyWidget(
                                    onBlur: (text) {
                                      setState(() {
                                        amount = text ?? '';
                                      });
                                    },
                                    value: field.value ?? '',
                                    initialValue: field.value ?? '',
                                    onChanged: field.didChange,
                                    placeholder: 'Nhập số tiền',
                                    maxLength: 13,
                                    borderless: true,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        CupertinoFormSection.insetGrouped(
                          header: Text('Thời gian'),
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 140,
                              child: FormBuilderField<DateTime>(
                                name: 'date',
                                initialValue:
                                    widget.model.expense?.date ??
                                    DateTime.now(),
                                validator: FormBuilderValidators.required(),
                                builder: (field) {
                                  return CupertinoDatePicker(
                                    initialDateTime:
                                        widget.model.expense?.date ??
                                        DateTime.now(),
                                    onDateTimeChanged: field.didChange,
                                    mode: CupertinoDatePickerMode.date,
                                    maximumDate: DateTime.now(),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        FormBuilderField<List<int>>(
                          name: 'members',
                          initialValue: widget.model.expense != null
                              ? widget.model.expense!.shares
                                    .map((e) => e.id)
                                    .toList()
                              : widget.model.members.map((e) => e.id).toList(),
                          validator: FormBuilderValidators.minLength(1),
                          builder: (fieldMembers) => FormBuilderField<int>(
                            name: 'payer',
                            initialValue:
                                widget.model.expense?.payerId ??
                                widget.model.members.first.id,
                            builder: (fieldPayer) => RadioGroup<int>(
                              onChanged: fieldPayer.didChange,
                              groupValue: fieldPayer.value,
                              child: CupertinoFormSection.insetGrouped(
                                header: Text('Người chi và chia sẻ'),
                                footer: Text(
                                  'Chọn người trả tiền và các người chia sẻ khoản chi này',
                                ),
                                children: widget.model.members
                                    .map(
                                      (member) => CheckboxMember(
                                        member: member,
                                        list: fieldMembers.value ?? [],
                                        onChanged: fieldMembers.didChange,
                                        payer: fieldPayer.value ?? 0,
                                        amount: amount,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: widget.model.expense != null
                    ? SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          pressedOpacity: 0.9,
                          onPressed: _isFormValid
                              ? () {
                                  _onSave(isSave: true);
                                }
                              : null,
                          child: Text('Cập nhật'),
                        ),
                      )
                    : Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: CupertinoButton.tinted(
                              pressedOpacity: 0.9,
                              onPressed: _isFormValid
                                  ? () {
                                      _onSave();
                                    }
                                  : null,
                              child: Text('Thêm và tạo mới'),
                            ),
                          ),
                          Expanded(
                            child: CupertinoButton.filled(
                              pressedOpacity: 0.9,
                              onPressed: _isFormValid
                                  ? () {
                                      _onSave(isSave: true);
                                    }
                                  : null,
                              child: Text('Thêm'),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckboxMember extends StatelessWidget {
  const CheckboxMember({
    super.key,
    required this.member,
    required this.list,
    required this.onChanged,
    required this.payer,
    required this.amount,
  });

  final Member member;
  final List<int> list;
  final void Function(List<int>) onChanged;
  final int payer;
  final String amount;

  void _onPressed(bool? checked) {
    final newList = List<int>.from(list);
    if (checked != null && checked) {
      newList.add(member.id);
    } else {
      newList.remove(member.id);
    }
    onChanged(newList);
  }

  @override
  Widget build(BuildContext context) {
    final isChecked = list.contains(member.id);
    final isPayer = payer == member.id;
    final amountTb =
        int.parse(amount.isEmpty ? '0' : amount) /
        (list.isEmpty ? 1 : list.length);
    return CupertinoFormRow(
      key: Key(member.id.toString()),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: CupertinoRadio<int>(value: member.id, enabled: isChecked),
          ),
          SizedBox(width: 12),
          AvatarWidget(name: member.id.toString()),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        (isChecked
                                ? CupertinoColors.label
                                : CupertinoColors.secondaryLabel)
                            .resolveFrom(context),
                  ),
                ),
                if (isChecked)
                  Text(
                    '${convertToCurrency(amountTb.toString())}đ',
                    style: TextStyle(
                      color: CupertinoColors.placeholderText.resolveFrom(
                        context,
                      ),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Transform.scale(
            scale: 1.4,
            child: CupertinoCheckbox(
              value: isChecked,
              onChanged: isPayer ? null : _onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
