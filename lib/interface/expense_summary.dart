class CategorySummary {
  final int categoryId;
  final double amount;

  CategorySummary({required this.categoryId, required this.amount});

  factory CategorySummary.fromJson(Map<String, dynamic> json) {
    return CategorySummary(
      categoryId: json['categoryId'] as int,
      amount: (json['amount'] as num).toDouble(),
    );
  }
}

class ExpenseMember {
  final int memberId;
  final String name;
  final double amount;
  final bool? own;

  ExpenseMember({
    required this.memberId,
    required this.name,
    required this.amount,
    this.own,
  });

  factory ExpenseMember.fromJson(Map<String, dynamic> json) {
    return ExpenseMember(
      memberId: json['memberId'] as int,
      name: json['name'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      own: json['own'] as bool?,
    );
  }
}

class ExpenseSummary {
  final double total;
  final List<CategorySummary> byCategory;
  final List<ExpenseMember> expenseMember;

  ExpenseSummary({
    required this.total,
    required this.byCategory,
    required this.expenseMember,
  });

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) {
    final categories = (json['by_category'] as List<dynamic>)
        .map((e) => CategorySummary.fromJson(e as Map<String, dynamic>))
        .toList();

    final members = (json['expense_member'] as List<dynamic>)
        .map((e) => ExpenseMember.fromJson(e as Map<String, dynamic>))
        .toList();

    return ExpenseSummary(
      total: (json['total'] as num).toDouble(),
      byCategory: categories,
      expenseMember: members,
    );
  }
}
