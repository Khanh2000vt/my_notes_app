class Member {
  final String id;
  final String name;
  final String roomId;
  final String userId;
  final DateTime? birthDay;
  final DateTime createdAt;

  Member({
    required this.id,
    required this.name,
    required this.roomId,
    required this.userId,
    this.birthDay,
    required this.createdAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      roomId: json['room_id'] as String,
      userId: json['user_id'] as String,
      birthDay: json['birth_day'] != null
          ? DateTime.tryParse(json['birth_day'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'room_id': roomId,
      'user_id': userId,
      'birth_day': birthDay?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
