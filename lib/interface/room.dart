import 'package:my_notes_app/interface/member.dart';

class Room {
  final String id;
  final DateTime createdAt;
  final String userId;
  final String name;
  final int priceRoom;
  final bool reminderMonthly;
  final int dayInMonth;
  final bool reminderDay;
  final DateTime timeInDay;
  final List<Member> members;

  Room({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.name,
    required this.priceRoom,
    required this.reminderMonthly,
    required this.dayInMonth,
    required this.reminderDay,
    required this.timeInDay,
    required this.members,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final membersJson = json['members'] as List<dynamic>? ?? [];
    return Room(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String,
      name: json['name'] as String,
      priceRoom: json['price_room'] as int,
      reminderMonthly: json['reminder_monthly'] as bool,
      dayInMonth: json['day_in_month'] as int,
      reminderDay: json['reminder_day'] as bool,
      timeInDay: DateTime.parse(json['time_in_day'] as String),
      members: membersJson.map((e) => Member.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'name': name,
      'price_room': priceRoom,
      'reminder_monthly': reminderMonthly,
      'day_in_month': dayInMonth,
      'reminder_day': reminderDay,
      'time_in_day': timeInDay.toIso8601String(),
      'members': members.map((m) => m.toJson()).toList(),
    };
  }
}
