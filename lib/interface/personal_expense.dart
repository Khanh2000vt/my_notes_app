class PersonalExpense {
  final int? id;
  final DateTime? createdAt;
  final int userId;
  final int amount;
  final String name;

  PersonalExpense({
    this.id,
    this.createdAt,
    required this.userId,
    required this.amount,
    required this.name,
  });

  factory PersonalExpense.fromJson(Map<String, dynamic> json) {
    return PersonalExpense(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as int,
      amount: json['amount'] as int,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'user_id': userId,
      'amount': amount,
      'name': name,
    };
  }

  Map<String, dynamic> toInsertJson() {
    return {'user_id': userId, 'amount': amount, 'name': name};
  }
}
