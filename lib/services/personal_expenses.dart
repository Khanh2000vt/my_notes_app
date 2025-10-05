import 'package:my_notes_app/interface/personal_expense.dart';
import 'package:my_notes_app/utils/string_handle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalExpensesService {
  late final SupabaseClient supabase;

  PersonalExpensesService() {
    supabase = Supabase.instance.client;
  }

  Future<List<PersonalExpense>> getExpensesByMonth(DateTime date) async {
    final userId = await getUserId();

    if (userId == null) {
      return [];
    }

    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0, 23, 59, 59);

    final response = await supabase
        .from('personal_expenses')
        .select()
        .eq('user_id', userId)
        .gte('created_at', startOfMonth.toIso8601String())
        .lte('created_at', endOfMonth.toIso8601String())
        .order('created_at', ascending: false);

    final data = response as List;

    return data
        .map((e) => PersonalExpense.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PersonalExpense?> addPersonalExpense(PersonalExpense expense) async {
    final response = await supabase
        .from('personal_expenses')
        .insert(expense.toInsertJson())
        .select()
        .single();

    return PersonalExpense.fromJson(response);
  }
}
