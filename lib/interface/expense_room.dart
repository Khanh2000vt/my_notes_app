import 'package:my_notes_app/interface/member.dart';

class ExpenseRoom {
  final int id;
  final DateTime date;
  final Member payer;
  final num amount;
  final List<Member> shares;
  final int roomId;
  final int category;
  final int payerId;
  final DateTime createdAt;

  ExpenseRoom({
    required this.id,
    required this.date,
    required this.payer,
    required this.amount,
    required this.shares,
    required this.roomId,
    required this.category,
    required this.payerId,
    required this.createdAt,
  });

  factory ExpenseRoom.fromJson(Map<String, dynamic> json) {
    return ExpenseRoom(
      id: json['id'] as int,
      date: DateTime.parse(json['date']),
      payer: Member.fromJson(json['payer']),
      amount: json['amount'] as num,
      shares: (json['shares'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      roomId: json['room_id'] as int,
      category: json['category'] as int,
      payerId: json['payer_id'] as int,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'payer': payer.toJson(),
      'amount': amount,
      'shares': shares.map((e) => e.toJson()).toList(),
      'room_id': roomId,
      'category': category,
      'payer_id': payerId,
      'created_at': createdAt.toUtc().toIso8601String(),
    };
  }
}
