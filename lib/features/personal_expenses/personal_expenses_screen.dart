import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes_app/helper/date_time_format.dart';
import 'package:my_notes_app/interface/personal_expense.dart';
import 'package:my_notes_app/services/personal_expenses.dart';
import 'package:my_notes_app/shared/atomic/form_row/form_row_widget.dart';
import 'package:my_notes_app/shared/atomic/sticky_header_delegate/sticky_header_delegate.dart';
import 'package:my_notes_app/shared/atomic/text_field_money/text_field_money_widget.dart';
import 'package:my_notes_app/shared/molecular/modal_popup/modal_popup.dart';
import 'package:my_notes_app/utils/string_handle.dart';

class PersonalExpensesScreen extends StatefulWidget {
  const PersonalExpensesScreen({super.key});

  @override
  State<PersonalExpensesScreen> createState() => _PersonalExpensesScreenState();
}

class _PersonalExpensesScreenState extends State<PersonalExpensesScreen> {
  late Future<List<PersonalExpense>> _futurePersonalExpense;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _futurePersonalExpense = PersonalExpensesService().getExpensesByMonth(
      selectedDate,
    );
  }

  Future<void> _onPressedTime(BuildContext ctx) async {
    await ModalPopupApp.date(
      context: ctx,
      value: selectedDate,
      mode: CupertinoDatePickerMode.monthYear,
      onChanged: (result) {
        setState(() {
          selectedDate = result;
        });
        _refresh();
      },
    );
  }

  Future<void> _onAdd(BuildContext ctx) async {
    final result = await showCupertinoModalPopup(
      context: ctx,
      builder: (context) => AddModalPopup(),
    );
    final userId = await getUserId();
    if (result != null && userId != null) {
      final name = result?['name'] as String;
      final amountStr = result?['amount'] as String;

      final newExpense = PersonalExpense(
        name: name,
        amount: int.tryParse(amountStr) ?? 0,
        userId: userId,
      );
      await PersonalExpensesService().addPersonalExpense(newExpense);
      _refresh();
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _futurePersonalExpense = PersonalExpensesService().getExpensesByMonth(
        selectedDate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: FutureBuilder<List<PersonalExpense>>(
        future: _futurePersonalExpense,
        builder: (context, snapshot) {
          final loading = snapshot.connectionState == ConnectionState.waiting;
          final data = snapshot.data ?? [];
          final total = data.fold<int>(
            0,
            (sum, e) => sum + (e.amount as int? ?? 0),
          );

          return CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                leading: CupertinoNavigationBarBackButton(
                  previousPageTitle: 'Trở lại',
                  onPressed: () {
                    context.pop();
                  },
                ),
                largeTitle: Text('Chi tiêu cá nhân'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(CupertinoIcons.calendar),
                      onPressed: () => _onPressedTime(context),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _onAdd(context),
                      child: Icon(CupertinoIcons.add),
                    ),
                  ],
                ),
              ),
              CupertinoSliverRefreshControl(onRefresh: _refresh),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  minHeight: 50,
                  maxHeight: 50,
                  child: Container(
                    color: CupertinoColors.systemBackground.resolveFrom(
                      context,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoListTile(
                          title: Text(
                            'Tổng chi tiêu',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          additionalInfo: Text(
                            '${convertToCurrency(total.toString())} k',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.systemBlue,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Divider(height: 0),
                      ],
                    ),
                  ),
                ),
              ),
              if (loading)
                SliverFillRemaining(
                  child: Center(child: CupertinoActivityIndicator()),
                )
              else if (data.isEmpty)
                SliverFillRemaining(
                  child: Center(child: Text("Không có khoản chi nào!")),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = data[index];
                    return CupertinoListTile(
                      title: Text(
                        item.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateTimeFormat.dateToDate(item.createdAt?.toLocal()),
                      ),
                      additionalInfo: Text(
                        '${convertToCurrency(item.amount.toString())} k',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.systemRed,
                          fontSize: 13,
                        ),
                      ),
                      backgroundColor:
                          (index % 2 == 0
                                  ? CupertinoColors.secondarySystemBackground
                                  : CupertinoColors.systemBackground)
                              .resolveFrom(context),
                    );
                  }, childCount: data.length),
                ),
            ],
          );
        },
      ),
    );
  }
}

class AddModalPopup extends StatefulWidget {
  const AddModalPopup({super.key});

  @override
  State<AddModalPopup> createState() => _AddModalPopupState();
}

class _AddModalPopupState extends State<AddModalPopup> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      isSurfacePainted: true,
      child: SafeArea(
        top: false,
        bottom: false,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FormBuilder(
            key: _formKey,
            child: Container(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              height: 250,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text('Huỷ'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoButton(
                        child: Text('Xác nhận'),
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            final formData = _formKey.currentState?.value;
                            Navigator.pop(context, formData);
                          }
                        },
                      ),
                    ],
                  ),

                  Expanded(
                    child: CupertinoFormSection.insetGrouped(
                      children: [
                        FormBuilderField<String>(
                          name: 'name',
                          validator: FormBuilderValidators.required(),
                          builder: (field) {
                            return CupertinoTextFormFieldRow(
                              placeholder: 'Tên khoản chi',
                              onChanged: (value) => field.didChange(value),
                            );
                          },
                        ),
                        FormBuilderField<String>(
                          name: 'amount',
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
