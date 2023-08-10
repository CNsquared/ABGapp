import 'package:abg_app/common/expenses.dart';

class Friend {
  String name;
  late List<Expense> expenses;

  Friend({required this.name}) {
    expenses = List.empty(growable: true);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "expenses": expenses.map((e) => e.toJson()).toList()};
  }

  Friend.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        expenses =
            (json['expenses'] as List).map((e) => Expense.fromJson(e)).toList();

  @override
  String toString() {
    return "Friend: {name: $name, expenses: $expenses}";
  }
}
