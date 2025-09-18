import 'package:my_notes_app/interface/expense.dart';

class ExpenseFormModel {
  final int? id;
  final int category;
  final String price;
  final DateTime date;
  final int payer;
  final List<int> members;

  ExpenseFormModel({
    this.id,
    required this.category,
    required this.price,
    required this.date,
    required this.payer,
    required this.members,
  });

  ExpenseFormModel copyWith({
    int? id,
    int? category,
    String? price,
    DateTime? date,
    int? payer,
    List<int>? members,
  }) {
    return ExpenseFormModel(
      id: id ?? this.id,
      category: category ?? this.category,
      price: price ?? this.price,
      date: date ?? this.date,
      payer: payer ?? this.payer,
      members: members ?? this.members,
    );
  }

  Expense toExpense() {
    return Expense.newExpense(
      id: id,
      category: category,
      amount: int.tryParse(price) ?? 0,
      date: date,
      payerId: payer,
      roomId: 1,
    );
  }

  Map<String, dynamic> toExpenseJson() {
    return toExpense().toJson();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      'category': category,
      'price': price,
      'date': date.toUtc().toIso8601String(),
      'payer': payer,
      'members': members,
    };
  }

  factory ExpenseFormModel.fromMap(Map<String, dynamic> map) {
    return ExpenseFormModel(
      id: map['id'] != null ? map['id'] as int : null,
      category: map['category'] as int,
      price: map['price'] as String,
      date: DateTime.parse(map['date']),
      payer: map['payer'] as int,
      members: List<int>.from((map['members'] as List<int>)),
    );
  }
}
