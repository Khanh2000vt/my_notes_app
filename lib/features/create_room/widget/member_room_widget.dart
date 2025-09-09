import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:my_notes_app/helper/modal_popup.dart';
import 'package:my_notes_app/interface/create_room.dart';
import 'package:my_notes_app/shared/atomic/avatar_widget/avatar_widget.dart';
import 'package:my_notes_app/utils/array.dart';

class MemberRoomWidget extends StatelessWidget {
  const MemberRoomWidget({super.key});

  void _onPressedAddMember(
    BuildContext ctx,
    FormFieldState<List<MemberRoomType>> filed,
    MemberRoomType? memberEdit,
  ) {
    void onSaveForm(MemberRoomType form) {
      final newList = replaceOrAddItemsToArrayByKey<MemberRoomType, String>(
        filed.value ?? [],
        [form],
        (e) => e.id,
      );
      filed.didChange(newList);
    }

    showCupertinoModalPopup(
      context: ctx,
      builder: (context) =>
          ModalPopupMember(initialValues: memberEdit, onSave: onSaveForm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<MemberRoomType>>(
      name: 'members',
      builder: (field) => CupertinoFormSection.insetGrouped(
        header: Text("THÀNH VIÊN: ${field.value?.length ?? 0}"),
        footer: const Text('Nhấn vào thành viên để hiện các tùy chọn sửa, xóa'),
        children: [
          if (field.value != null && field.value!.isNotEmpty)
            SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: field.value?.length ?? 0,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return CardMemberRoom(
                      onEdit: () => _onPressedAddMember(
                        context,
                        field,
                        field.value![index],
                      ),
                      onRemove: () => field.didChange(
                        (field.value ?? [])
                            .where(
                              (element) => element.id != field.value![index].id,
                            )
                            .toList(),
                      ),
                      member: MemberRoomType(
                        id: field.value![index].id,
                        name: field.value![index].name,
                        birthDay: field.value![index].birthDay,
                      ),
                    );
                  },
                ),
              ),
            ),

          Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
              child: Text('Thêm thành viên'),
              onPressed: () => _onPressedAddMember(context, field, null),
            ),
          ),
        ],
      ),
    );
  }
}

class CardMemberRoom extends StatelessWidget {
  const CardMemberRoom({
    super.key,
    required this.member,
    required this.onEdit,
    required this.onRemove,
  });

  final MemberRoomType member;
  final void Function() onEdit;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      padding: EdgeInsets.zero,
      onPressed: () => ActionApp.editActionSheet(
        context: context,
        onEdit: onEdit,
        onRemove: onRemove,
      ),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: CupertinoColors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AvatarWidget(name: member.name, radius: 16),
              SizedBox(height: 10),
              Text(
                member.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.label.resolveFrom(context),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModalPopupMember extends StatefulWidget {
  const ModalPopupMember({super.key, required this.onSave, this.initialValues});

  final void Function(MemberRoomType) onSave;
  final MemberRoomType? initialValues;

  @override
  State<ModalPopupMember> createState() => _ModalPopupMemberState();
}

class _ModalPopupMemberState extends State<ModalPopupMember> {
  final formKeyMember = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formKeyMember.currentState?.patchValue({
        'name': widget.initialValues?.name ?? '',
        'birth_day': widget.initialValues?.birthDay ?? DateTime.now(),
      });
      formKeyMember.currentState?.save();
    });
  }

  void _onSave(BuildContext context) {
    if (formKeyMember.currentState?.saveAndValidate() ?? false) {
      final data = formKeyMember.currentState?.value;
      if (data == null) {
        return;
      }
      print('data: $data');
      final newItem = MemberRoomType(
        id:
            widget.initialValues?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: data['name'] ?? '',
        birthDay: data['birth_day'] ?? DateTime.now(),
      );
      widget.onSave(newItem);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKeyMember,
      child: CupertinoPopupSurface(
        isSurfacePainted: true,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FormBuilderField<String>(
            name: 'name',
            validator: FormBuilderValidators.required(),
            builder: (field) => SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  spacing: 16,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AvatarWidget(name: field.value ?? '', radius: 52),
                    CupertinoTextField(
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
                      placeholder: "Nhập tên",
                      maxLength: 100,
                      onChanged: field.didChange,
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.words,
                    ),
                    Column(
                      spacing: 4,
                      children: [
                        Text(
                          'Ngày sinh',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.label.resolveFrom(context),
                          ),
                        ),
                        SizedBox(
                          height: 130,
                          child: FormBuilderField<DateTime>(
                            name: 'birth_day',
                            validator: FormBuilderValidators.dateTime(),
                            initialValue:
                                widget.initialValues?.birthDay ??
                                DateTime.now(),
                            builder: (field) => CupertinoDatePicker(
                              onDateTimeChanged: field.didChange,
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: field.value ?? DateTime.now(),
                              use24hFormat: true,
                              maximumDate: DateTime.now(),
                            ),
                          ),
                        ),
                      ],
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
      ),
    );
  }
}
