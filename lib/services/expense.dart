import 'package:my_notes_app/features/expense/model/expense_form_model.dart';
import 'package:my_notes_app/interface/expense_room.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:my_notes_app/services/expense_share.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseService {
  late final SupabaseClient supabase;

  ExpenseService() {
    supabase = Supabase.instance.client;
  }

  Future<List<ExpenseRoom>> fetchExpensesDateTimeByRoomId(
    int roomId,
    DateTime date,
  ) async {
    final response = await supabase.rpc(
      'get_expenses_by_month',
      params: {'target_date': date.toIso8601String()},
    );
    if (response == null) {
      return [];
    }
    return (response as List<dynamic>)
        .map((e) => ExpenseRoom.fromJson(e))
        .toList();
  }

  Future<void> upsertExpenseRoom(ExpenseFormModel expenseForm) async {
    int? expenseId = expenseForm.id;
    if (expenseId == null) {
      final res = await supabase
          .from('expenses')
          .insert(expenseForm.toExpenseJson())
          .select()
          .single();
      expenseId = res['id'] as int;
    } else {
      await supabase
          .from('expenses')
          .update(expenseForm.toExpenseJson())
          .eq('id', expenseId)
          .select()
          .single();
      await ExpenseShareService().deleteByExpenseId(expenseId);
    }
    final participants = expenseForm.members;
    final amount = expenseForm.price;
    await ExpenseShareService().updateExpenseShare(
      expenseId,
      participants,
      amount,
    );
  }

  Future<ExpenseSummary> fetchRoomExpenseSummary(
    DateTime date,
    int roomId,
  ) async {
    final response = await supabase.rpc(
      'get_room_expense_summary',
      params: {'target_date': date.toIso8601String(), 'target_room': roomId},
    );

    if (response == null) {
      return ExpenseSummary(byCategory: [], expenseMember: [], total: 0);
    }
    return ExpenseSummary.fromJson(response);
  }
}
