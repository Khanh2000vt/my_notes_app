import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';
import 'package:my_notes_app/shared/atomic/text_field_money/text_field_money_widget.dart';

class RoomInformationWidget extends StatelessWidget {
  const RoomInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: const Text("PHÒNG"),
      children: [
        FormBuilderField<String>(
          name: 'name',
          validator: FormBuilderValidators.required(),
          builder: (field) => FormRowWidget(
            label: 'Tên phòng',
            error: field.errorText,
            child: CupertinoTextField.borderless(
              textAlign: TextAlign.right,
              placeholder: "Nhập tên phòng",
              maxLength: 100,
              onChanged: field.didChange,
            ),
          ),
        ),

        FormBuilderField<String>(
          name: 'price_room',
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.integer(),
            FormBuilderValidators.positiveNumber(),
          ]),
          builder: (field) => FormRowWidget(
            label: 'Tiền thuê',
            error: field.errorText,
            child: TextFieldMoneyWidget(
              onChanged: field.didChange,
              placeholder: 'Nhập tiền thuê',
              maxLength: 13,
            ),
          ),
        ),
      ],
    );
  }
}
