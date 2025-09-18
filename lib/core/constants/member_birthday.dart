class MemberBirthday {
  final int id;
  final String name;
  final int day;
  final int month;
  MemberBirthday({
    required this.id,
    required this.name,
    required this.day,
    required this.month,
  });
}

final List<MemberBirthday> memberBirthdays = [
  MemberBirthday(id: 1, name: 'Đào Flora', day: 23, month: 2),
  MemberBirthday(id: 2, name: 'Khánh Macro', day: 5, month: 11),
  MemberBirthday(id: 3, name: 'Anh Quốc', day: 23, month: 4),
  MemberBirthday(id: 4, name: 'Đức Việt', day: 13, month: 2),
];
