import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_data_model.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}


class _ExpensesState extends State<Expenses> {

 //Make a dummy list using Expense data model Class
  final List<Expense> _registeredExpense = [];
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true, //control the keyboard
      context: context, builder: (ctx) => 
      NewExpense(onAddExpense: _addExpense)); //Passing the add expense function
  }

  //Add the item in the list dynamically
  void _addExpense(Expense expense){
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  //Remove the item in the list dynamically
  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          }),)
    );
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
        child: Text('No Expenses found, Start adding some!')
      );

      if(_registeredExpense.isNotEmpty){
        mainContent = ExpensesList(
            expenses: _registeredExpense,
            onRemoveExpense: _removeExpense);
      }


      return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Expense Tracker',),
        actions: [
          IconButton(
            onPressed:_openAddExpenseOverlay,
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body: width <  600 
      ? Column(
          children: [
            Chart(expenses: _registeredExpense),
            Expanded(child: mainContent), //Update the UI by calling registeredExpese variable  
          ],
        )
      : Row(
          children: [
            Expanded(child: Chart(expenses: _registeredExpense),),
            Expanded(child: mainContent), //Update the UI by calling registeredExpese variable  
          ],
        ),
      );
    }
}