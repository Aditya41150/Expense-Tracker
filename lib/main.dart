import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

void main() { 
  runApp(
    const MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Expenses(), // expenses class from Expenses.dart
    ),
  );
}