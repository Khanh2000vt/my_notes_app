class Member {
  final int id;
  final String name;
  final int roomId;
  final DateTime? birthDay;
  final DateTime? createdAt;
  final bool? own;

  Member({
    required this.id,
    required this.name,
    required this.roomId,
    this.birthDay,
    this.createdAt,
    this.own,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as int,
      name: json['name'] as String,
      roomId: json['room_id'] as int,
      birthDay: json['birth_day'] != null
          ? DateTime.tryParse(json['birth_day'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      own: json['own'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'room_id': roomId,
      'birth_day': birthDay?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'own': own,
    };
  }
}
