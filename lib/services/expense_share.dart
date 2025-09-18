import 'package:my_notes_app/interface/expense_shares.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseShareService {
  late final SupabaseClient supabase;

  ExpenseShareService() {
    supabase = Supabase.instance.client;
  }

  Future<List<ExpenseShare>> fetchListExpenseShareByExpenseId(
    int expenseId,
  ) async {
    final response = await supabase
        .from('expense_shares')
        .select()
        .eq('expense_id', expenseId);

    if (response.isEmpty) return [];

    return (response as List<dynamic>)
        .map((e) => ExpenseShare.fromJson(e))
        .toList();
  }

  Future<void> updateExpenseShare(
    int expenseId,
    List<int> participants,
    String amount,
  ) async {
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

  Future<void> deleteByExpenseId(int expenseId) async {
    await supabase.from('expense_shares').delete().eq('expense_id', expenseId);
  }
}
