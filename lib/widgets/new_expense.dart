import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// yMd is a method of intl package

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category selectedCategory = Category.leisure;

  void presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Add Expense'),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                      prefixText: '\₹ ', labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Text(_selectedDate == null
                        ? 'No date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: () {
                          presentDatePicker();
                        },
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                            child: Text(category.name.toString())),
                      )
                      .toList(),
                      
                  onChanged: (value) {
                    if(value == null) {
                      return;
                    }
                    setState(() { // updating the state of selected category
                      selectedCategory = value;
                    });
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // closes the modal bottom sheet
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    print(_amountController.text);
                    print(_titleController.text);
                    print(_selectedDate);
                  },
                  child: const Text('Save expense')),
            ],
          )
        ],
      ),
    );
  }
}
