class ExpenseShare {
  final DateTime? createdAt;
  final int memberId;
  final int expenseId;
  final num shareAmount;

  ExpenseShare({
    this.createdAt,
    required this.memberId,
    required this.expenseId,
    required this.shareAmount,
  });

  factory ExpenseShare.fromJson(Map<String, dynamic> map) {
    return ExpenseShare(
      createdAt: DateTime.parse(map['created_at'] as String),
      memberId: map['member_id'] as int,
      expenseId: map['expense_id'] as int,
      shareAmount: map['share_amount'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'expense_id': expenseId,
      'share_amount': shareAmount,
    };
  }

  ExpenseShare copyWith({
    DateTime? createdAt,
    int? memberId,
    int? expenseId,
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
