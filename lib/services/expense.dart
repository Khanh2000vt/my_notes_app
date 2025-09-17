import 'package:my_notes_app/interface/expense.dart';
import 'package:my_notes_app/interface/expense_summary.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseService {
  late final SupabaseClient supabase;

  ExpenseService() {
    supabase = Supabase.instance.client;
  }

  Future<List<Expense>> fetchExpensesDateTimeByRoomId(
    int roomId,
    DateTime date,
  ) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);
    final response = await supabase
        .from('expenses')
        .select('''
          *,
          payer: members!payer_id (*),
          shares: expense_shares(member:members!member_id(*))
        ''')
        .eq('room_id', roomId)
        .gte('date', startOfMonth.toIso8601String())
        .lte('date', endOfMonth.toIso8601String());
    if (response.isEmpty) return [];
    return (response as List<dynamic>).map((e) => Expense.fromJson(e)).toList();
  }

  Future<void> upsertExpenseRoom(Map<String, dynamic> formData) async {
    int? expenseId = formData['id'];
    if (expenseId == null) {
      // Tạo mới
      Expense newExpense = Expense.newExpense(
        category: formData['category'] as int? ?? 0,
        amount: int.tryParse(formData['price'] ?? '0'),
        date: formData['date'] as DateTime?,
        roomId: 1,
        payerId: formData['payer'],
      );
      final res = await supabase
          .from('expenses')
          .insert(newExpense.toJson())
          .select()
          .single();
      expenseId = res['id'] as int;
    } else {
      // Cập nhật
      Expense newExpense = Expense.newExpense(
        id: expenseId,
        category: formData['category'] as int? ?? 0,
        amount: int.tryParse(formData['price'] ?? '0'),
        date: formData['date'] as DateTime?,
        roomId: 1,
        payerId: formData['payer'],
      );
      await supabase
          .from('expenses')
          .update(newExpense.toJson())
          .eq('id', expenseId)
          .select()
          .single();
      await supabase
          .from('expense_shares')
          .delete()
          .eq('expense_id', expenseId);
    }
    final participants = formData['members'] as List<int>;
    final amount = formData['price'] as String? ?? '0';
    final amountTb =
        int.parse(amount.isEmpty ? '0' : amount) /
        (participants.isEmpty ? 1 : participants.length);

    final List<dynamic> newShares = participants
        .map(
          (p) => {
            'expense_id': expenseId,
            'member_id': p,
            'share_amount': amountTb,
          },
        )
        .toList();
    await supabase.from('expense_shares').insert(newShares).select();
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
