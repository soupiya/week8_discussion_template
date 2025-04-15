import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week8datapersistence/models/expense_model.dart';

class FirebaseExpenseApi {
  static final db = FirebaseFirestore.instance;

  // continuous data of firebase data, snapshot is a function
  Stream<QuerySnapshot> getAllExpenses() {
  return db.collection("expenses").snapshots();
  }

  Future<String> addExpense(Map<String, dynamic> expense) async {
    //JSON format Map<String, dynamic>
    try {
      await db.collection("expenses").add(expense);
      return "Successfully added expense!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> deleteExpense(String? id) async {
    try {
      await db.collection("expenses").doc(id).delete();
      return "Successfully deleted expense!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Future<String> updateExpense(Expense expense) async {
  try {
    await db.collection("expenses").doc(expense.id).update(expense.toJson(expense));
    return "Successfully updated expense!";
  } on FirebaseException catch (e) {
    return "Failed with error '${e.code}: ${e.message}";
  }
}

}