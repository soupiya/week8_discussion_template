import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week8datapersistence/api/firebase_expense_api.dart';
import '../models/expense_model.dart';

class ExpenseListProvider with ChangeNotifier {
  late FirebaseExpenseApi firebaseService;
  late Stream<QuerySnapshot> _expensesStream;

  ExpenseListProvider() {
    firebaseService = FirebaseExpenseApi();
    fetchExpenses();
  }

  // getter
  Stream<QuerySnapshot> get expense => _expensesStream;

  // TODO: get all expense items from Firestore
  void fetchExpenses() {
    _expensesStream = firebaseService.getAllExpenses();
    notifyListeners();
  }

  // TODO: add expense item and store it in Firestore
  void addExpense(Expense item) {
    firebaseService.addExpense(item.toJson(item));
    notifyListeners();
  }

  // TODO: edit a expense item and update it in Firestore
  void editExpense(Expense item, String newTitle) {
    notifyListeners();
  }

  // TODO: delete a expense item and update it in Firestore
  void deleteExpense(Expense item) {
    print(item.id);
    print(item.name);
    firebaseService.deleteExpense(item.id);
    notifyListeners();
  }

  // TODO: modify a expense status and update it in Firestore
  void toggleStatus (Expense item, bool status) async {
    item.isPaid = status;
    await firebaseService.updateExpense(item);
    notifyListeners();
  }
}
