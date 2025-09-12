class ExpenseShare {
  final DateTime createdAt;
  final String memberId;
  final String expenseId;
  final num shareAmount;

  ExpenseShare({
    required this.createdAt,
    required this.memberId,
    required this.expenseId,
    required this.shareAmount,
  });

  factory ExpenseShare.fromJson(Map<String, dynamic> map) {
    return ExpenseShare(
      createdAt: DateTime.parse(map['created_at'] as String),
      memberId: map['member_id'] as String,
      expenseId: map['expense_id'] as String,
      shareAmount: map['share_amount'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'member_id': memberId,
      'expense_id': expenseId,
      'share_amount': shareAmount,
    };
  }

  ExpenseShare copyWith({
    DateTime? createdAt,
    String? memberId,
    String? expenseId,
    num? shareAmount,
  }) {
    return ExpenseShare(
      createdAt: createdAt ?? this.createdAt,
      memberId: memberId ?? this.memberId,
      expenseId: expenseId ?? this.expenseId,
      shareAmount: shareAmount ?? this.shareAmount,
    );
  }
}
