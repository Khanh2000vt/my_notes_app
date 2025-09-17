import 'package:my_notes_app/interface/member.dart';

class Room {
  final int id;
  final DateTime createdAt;
  final String name;
  final int priceRoom;
  final List<Member> members;

  Room({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.priceRoom,
    required this.members,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final membersJson = json['members'] as List<dynamic>? ?? [];
    return Room(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      name: json['name'] as String,
      priceRoom: json['price_room'] as int,
      members: membersJson.map((e) => Member.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'price_room': priceRoom,
      'members': members.map((m) => m.toJson()).toList(),
    };
  }
}
