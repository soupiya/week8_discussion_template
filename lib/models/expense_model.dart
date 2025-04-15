import 'dart:convert';

class Expense {
  String? id;
  String name;
  String description;
  String category;
  String amount;
  bool isPaid;

  Expense({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.amount,
    required this.isPaid
  });

  // Factory constructor to instantiate object from json format
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      amount: json['amount'],
      isPaid: json['isPaid']
    );
  }

  static List<Expense> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Expense>((dynamic d) => Expense.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Expense expense) {
    return {
      'name': name,
      'description': description,
      'category': category,
      'amount': amount,
      'isPaid': isPaid
    };
  }
}
