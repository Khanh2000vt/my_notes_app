import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final DateTime createdAt;
  final String? name;
  final num? amount;
  final DateTime? date;
  final String? roomId;
  final String? payerId;

  Expense({
    required this.id,
    required this.createdAt,
    this.name,
    this.amount,
    this.date,
    this.roomId,
    this.payerId,
  });

  /// Convert JSON -> Expenses
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'] as String?,
      amount: json['amount'] as num?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      roomId: json['room_id'] as String?,
      payerId: json['payer_id'] as String?,
    );
  }

  /// Convert Expenses -> JSON (để insert/update Supabase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toUtc().toIso8601String(),
      'name': name,
      'amount': amount,
      'date': date?.toUtc().toIso8601String(),
      'room_id': roomId,
      'payer_id': payerId,
    };
  }

  /// Factory để tạo mới record với id random
  factory Expense.newExpense({
    String? id,
    String? name,
    num? amount,
    DateTime? date,
    String? roomId,
    String? payerId,
  }) {
    return Expense(
      id: id ?? const Uuid().v4(),
      createdAt: DateTime.now().toUtc(),
      name: name,
      amount: amount,
      date: date,
      roomId: roomId,
      payerId: payerId,
    );
  }
}
