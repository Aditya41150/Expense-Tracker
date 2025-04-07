import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20, 
          vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('₹ ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),//takes up app the space between 2 widgets
                // hence row will be placed at right
                Row(
                  children: [
                    const Icon(Icons.work),
                    const SizedBox(width: 7,),
                    Text(expense.date.toString())
            
                  ],
                )
              ],
            )

          ],
        )
      ),
    );
  }
}
