import 'dart:convert';

import 'package:my_notes_app/interface/expense_room.dart';
import 'package:my_notes_app/interface/member.dart';

class ExpenseModel {
  final List<Member> members;
  final ExpenseRoom? expense;

  ExpenseModel({required this.members, this.expense});

  ExpenseModel copyWith({List<Member>? members, ExpenseRoom? expense}) {
    return ExpenseModel(
      members: members ?? this.members,
      expense: expense ?? this.expense,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'members': members, 'expense': expense};
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(members: map['members'], expense: map['expense']);
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
