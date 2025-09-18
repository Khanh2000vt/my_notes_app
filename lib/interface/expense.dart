class Expense {
  final int? id;
  final DateTime? createdAt;
  final int category;
  final num? amount;
  final DateTime? date;
  final int? roomId;
  final int? payerId;

  Expense({
    this.id,
    this.createdAt,
    required this.category,
    this.amount,
    this.date,
    this.roomId,
    this.payerId,
  });

  /// Convert JSON -> Expenses
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      category: json['category'] as int,
      amount: json['amount'] as num?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      roomId: json['room_id'] != null ? json['room_id'] as int : null,
      payerId: json['payer_id'] != null ? json['payer_id'] as int : null,
    );
  }

  /// Convert Expenses -> JSON (để insert/update Supabase)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt!.toUtc().toIso8601String(),
      'category': category,
      'amount': amount,
      'date': date?.toIso8601String(),
      'room_id': roomId,
      'payer_id': payerId,
    };
  }

  /// Factory để tạo mới record với id random
  factory Expense.newExpense({
    int? id,
    required int category,
    num? amount,
    DateTime? date,
    int? roomId,
    int? payerId,
  }) {
    return Expense(
      category: category,
      amount: amount,
      date: date,
      roomId: roomId,
      payerId: payerId,
    );
  }
}
