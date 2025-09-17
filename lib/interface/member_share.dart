class MemberShare {
  final int memberId;
  final String name;
  final double amount;

  MemberShare({
    required this.memberId,
    required this.name,
    required this.amount,
  });

  factory MemberShare.fromJson(Map<String, dynamic> json) {
    return MemberShare(
      memberId: json['member_id'] as int,
      name: json['name'] ?? '',
      amount: (json['amount'] as num).toDouble(),
    );
  }
}
