import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense_model.dart';
import '../providers/expense_provider.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    // access the list of expenses in the provider
    Stream<QuerySnapshot> expensesStream = context.watch<ExpenseListProvider>().expense;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense"),
      ),
      body: StreamBuilder(
        stream: expensesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Expenses Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Expense expense = Expense.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
                  // snapshot.data?.docs[index] // {..., id, data()}
                  // snapshot.data?.docs[index].id // id from firestore
                  // snapshot.data?.docs[index].data() // contents of Expense from firestore
                  // snapshot.data?.docs[index].data().title
                  // snapshot.data?.docs[index].data().completed
              return Dismissible(
                key: Key(expense.id.toString()),
                onDismissed: (direction) {
                  expense.id = snapshot.data!.docs[index].id;
                  context.read<ExpenseListProvider>().deleteExpense(expense);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${expense.name} dismissed')));
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(expense.name),
                  leading: Checkbox(
                    value: expense.isPaid,
                    onChanged: (bool? value) {
                      expense.id = snapshot.data!.docs[index].id;
                      context.read<ExpenseListProvider>().toggleStatus(expense, value!);
                    },
                  ),
                  onTap: (){
                    
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          expense.id = snapshot.data!.docs[index].id;
                          context.read<ExpenseListProvider>().deleteExpense(expense);
                        },
                        icon: const Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-expense');
        },
        child: const Icon(Icons.add_outlined),
      ),

    );
  }
}
