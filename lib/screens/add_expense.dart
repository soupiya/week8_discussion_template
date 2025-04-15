import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8datapersistence/models/expense_model.dart';
import 'package:week8datapersistence/providers/expense_provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> category = [
    "Bills",
    "Transportation",
    "Food",
    "Utilities",
    "Health",
    "Entertainment",
    "Miscellaneous"
  ];

  String _category = "";
  String _name = "";
  String _description = "";
  String _amount = "";
  bool _isPaid = false;

  @override
  void initState() {
    super.initState();
    _category = category.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  onChanged: (value){
                    setState(() {
                      _name = value;
                    });
                  },
                  validator: (value) {
                    if(_name.isEmpty){
                      return "Name is required";
                    }else{
                      return null;
                    }
                  }
                ),

                // Description
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  onChanged: (value){
                    setState(() {
                      _description = value;
                    });
                  },
                  validator: (value) {
                    if(_description.isEmpty){
                      return "Description is required";
                    }else{
                      return null;
                    }
                  }
                ),

                // Food
                DropdownButtonFormField(
                  value: _category,
                  dropdownColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                  items: category.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  validator: (value){
                    if(_category.isEmpty){
                      return "Category is required";
                    }else{
                      return null;
                    }
                  },
                ),

                // Amount
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Amount",
                  ),
                  onChanged: (value){
                    setState(() {
                      _amount = value;
                    });
                  },
                  validator: (value) {
                    if(_amount.isEmpty){
                      return "Amount is required";
                    }else{
                      if(double.parse(_amount) > 0){
                        return null;
                      }else{
                        return "Amount should be greater than 0.";
                      }
                    }
                  }
                ),
                
                // 'Add Expense' Button
                ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();

                      // Create the an expense entry with its info
                      Expense newExpense = Expense(
                        id: "",
                        name: _name,
                        description: _description,
                        category: _category,
                        amount: _amount,
                        isPaid: _isPaid,
                      );

                      // Save the expense entry
                      context.read<ExpenseListProvider>().addExpense(newExpense);
                      // Go back to the expense list
                      Navigator.of(context).pop();
                      
                    }else{
                      print("Errors detected.");
                    }
                  }, 
                  child: const Text("Add Expense")
                )
              ],
            )
          ),
        )
      )
    );
  }
}