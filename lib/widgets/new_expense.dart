import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';


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

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text); // if(string entered -> NULL < tryparse('123.5')-> 123.5)
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0; // if amount is invalid (not a number or less than 0)
        
    if(_titleController.text.trim().isEmpty || amountIsInvalid == true || _selectedDate == null) {
     showDialog( // this is the error dialog
      context: context,
      builder: (ctx) => AlertDialog(
      title: const Text('Invalid input'),
      content: const Text('Please make sure a valid title, amount and date was entered.'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(ctx);
        }, 
        child: const Text('Okay'),
        )
      ],
     ),
     );
     return;
    }
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
                      prefixText: '₹ ', labelText: 'Amount'),
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
                    //saveExpense(); // save the expense
                    Navigator.of(context).pop(); // closes the modal bottom sheet
                  },
                  child: const Text('Save expense')),
            ],
          )
        ],
      ),
    );
  }
}
