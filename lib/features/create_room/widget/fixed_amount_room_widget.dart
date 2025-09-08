import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_notes_app/helper/modal_popup.dart';
import 'package:my_notes_app/interface/create_room.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';
import 'package:my_notes_app/shared/atomic/text_field_money/text_field_money_widget.dart';
import 'package:my_notes_app/utils/array.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class FixedAmountRoomWidget extends StatelessWidget {
  const FixedAmountRoomWidget({super.key});

  void _onPressedAddFixedAmount(
    BuildContext ctx,
    FormFieldState<List<CardFixedAmountType>> fieldList,
    CardFixedAmountType? itemEdit,
  ) {
    void onSaveForm(CardFixedAmountType form) {
      final newList =
          replaceOrAddItemsToArrayByKey<CardFixedAmountType, String>(
            fieldList.value ?? [],
            [form],
            (e) => e.id,
          );
      fieldList.didChange(newList);
    }

    showCupertinoModalPopup(
      context: ctx,
      builder: (context) =>
          ModalPopFixedAmount(initialValues: itemEdit, onSave: onSaveForm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<CardFixedAmountType>>(
      name: 'fixed_amounts',
      builder: (field) => CupertinoFormSection.insetGrouped(
        header: const Text("CÁC KHOẢN CỐ ĐỊNH"),
        footer: const Text(
          'Nhấn vào khoản cố định để hiện các tùy chọn sửa, xóa',
        ),
        children: [
          ...(field.value ?? []).map(
            (e) => CardFixedAmountRoom(
              props: e,
              onEdit: () => _onPressedAddFixedAmount(context, field, e),
              onRemove: () => field.didChange(
                (field.value ?? [])
                    .where((element) => element.id != e.id)
                    .toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
              child: Text('Thêm khoản cố định'),
              onPressed: () => _onPressedAddFixedAmount(context, field, null),
            ),
          ),
        ],
      ),
    );
  }
}

class CardFixedAmountRoom extends StatelessWidget {
  const CardFixedAmountRoom({
    super.key,
    required this.props,
    required this.onEdit,
    required this.onRemove,
  });

  final CardFixedAmountType props;
  final void Function() onEdit;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      child: FormRowWidget(
        padding: EdgeInsets.zero,
        label: props.label,
        child: Text(
          '${convertToCurrency(props.value)}₫',
          style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
        ),
      ),
      onPressed: () => ActionApp.editActionSheet(
        context: context,
        onEdit: onEdit,
        onRemove: onRemove,
      ),
    );
  }
}

class ModalPopFixedAmount extends StatefulWidget {
  const ModalPopFixedAmount({
    super.key,
    required this.onSave,
    this.initialValues,
  });

  final void Function(CardFixedAmountType) onSave;
  final CardFixedAmountType? initialValues;

  @override
  State<ModalPopFixedAmount> createState() => _ModalPopFixedAmountState();
}

class _ModalPopFixedAmountState extends State<ModalPopFixedAmount> {
  final formKeyFixed = GlobalKey<FormBuilderState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formKeyFixed.currentState?.patchValue({
        'name_fixed': widget.initialValues?.label ?? '',
        'price_fixed': widget.initialValues?.value ?? '',
      });
      formKeyFixed.currentState?.save();
    });
  }

  void _onSave(BuildContext context) {
    if (formKeyFixed.currentState?.saveAndValidate() ?? false) {
      final data = formKeyFixed.currentState?.value;
      if (data == null) {
        return;
      }
      final newItem = CardFixedAmountType(
        id:
            widget.initialValues?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        label: data['name_fixed'] ?? '',
        value: data['price_fixed'] ?? '',
      );
      widget.onSave(newItem);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKeyFixed,
      child: CupertinoPopupSurface(
        isSurfacePainted: true,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Khoản cố định',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.label.resolveFrom(context),
                    ),
                  ),

                  FormBuilderField<String>(
                    name: 'name_fixed',
                    validator: FormBuilderValidators.required(),
                    builder: (field) => FormRowWidget(
                      label: 'Tên khoản',
                      error: field.errorText,
                      child: CupertinoTextField(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 12,
                        ),
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: field.value ?? '',
                            selection: TextSelection.collapsed(
                              offset: (field.value ?? '').length,
                            ),
                          ),
                        ),
                        textAlign: TextAlign.right,
                        placeholder: "Nhập tên khoản cố định",
                        maxLength: 100,
                        onChanged: field.didChange,
                      ),
                    ),
                  ),
                  FormBuilderField<String>(
                    name: 'price_fixed',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.positiveNumber(),
                    ]),
                    builder: (field) => FormRowWidget(
                      label: 'Số tiền',
                      error: field.errorText,
                      child: TextFieldMoneyWidget(
                        onChanged: field.didChange,
                        placeholder: 'Nhập tiền',
                        maxLength: 13,
                        value: field.value,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.tinted(
                      child: Text('Lưu'),
                      onPressed: () => _onSave(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
