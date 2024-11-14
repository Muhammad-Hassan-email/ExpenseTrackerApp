import 'package:expense_tracker/models/expense_data_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,{super.key});
  final Expense expense; 

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
            style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('Rs.${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(cateogryIcons[expense.category]), //calling the icons
                    const SizedBox(height: 5,),
                    Text(expense.date.toString()),
                  ],
                ),
              ],
            )
          ],
        ),
      ), //calling item title
    );
  }
}