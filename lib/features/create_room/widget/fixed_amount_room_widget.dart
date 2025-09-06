import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_notes_app/helper/modal_popup.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';
import 'package:my_notes_app/shared/atomic/text_field_money/text_field_money_widget.dart';

class FixedAmountRoomWidget extends StatelessWidget {
  FixedAmountRoomWidget({super.key});

  final GlobalKey formKeyFixed = GlobalKey<FormBuilderState>();

  void _onPressedAddFixedAmount(BuildContext ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) => FormBuilder(
        key: formKeyFixed,
        child: Container(
          height: 250 + MediaQuery.of(context).viewInsets.bottom,
          color: CupertinoColors.systemBackground.resolveFrom(context),

          child: Column(
            children: [
              FormBuilderField<String>(
                name: 'name_fixed',
                validator: FormBuilderValidators.required(),
                builder: (field) => FormRowWidget(
                  label: 'Tên khoản',
                  error: field.errorText,
                  child: CupertinoTextField.borderless(
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: const Text("CÁC KHOẢN CỐ ĐỊNH"),
      footer: const Text(
        'Nhấn vào khoản cố định để hiện các tùy chọn sửa, xóa',
      ),
      children: [
        CardFixedAmountRoom(),
        Align(
          alignment: Alignment.centerLeft,
          child: CupertinoButton(
            child: Text('Thêm khoản cố định'),
            onPressed: () => _onPressedAddFixedAmount(context),
          ),
        ),
      ],
    );
  }
}

class CardFixedAmountRoom extends StatelessWidget {
  const CardFixedAmountRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      child: FormRowWidget(
        padding: EdgeInsets.zero,
        label: 'Tiền thang máy',
        child: Text(
          '500.000₫',
          style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
        ),
      ),
      onPressed: () => ActionApp.editActionSheet(
        context: context,
        onEdit: () {},
        onRemove: () {},
      ),
    );
  }
}
