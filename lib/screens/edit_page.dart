import 'package:flutter/material.dart';
import 'package:week8datapersistence/models/expense_model.dart';

class MyExpenseInfo extends StatelessWidget {
  final Expense expense;
  final int index;

  MyExpenseInfo({required this.expense, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense #${index+1}")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.name),
              Text("Description: ${expense.description}"),
              Text("Category: ${expense.category}"),
              Text("Amount: ${expense.amount}"),
              Text("Is Paid? [Y/N]: ${expense.isPaid ? 'Y' : 'N'}")
            ],
        ),
      
      )
    );
  }
}