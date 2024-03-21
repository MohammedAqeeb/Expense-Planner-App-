import 'package:expense_planner_app/features/home/add_expense/provider.dart';
import 'package:expense_planner_app/features/home/add_expense/screens/add_expense.dart';
import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TransactionExpenseType { add, edit }

/// Common screen for both add and edit based on enum type
///
class ExpensePickerScreen extends ConsumerWidget {
  final TransactionExpenseType expenseType;
  final TransactionExpense? transactionExpense;
  const ExpensePickerScreen({
    super.key,
    required this.expenseType,
    this.transactionExpense,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.watch(expenseManagerPr);
    manager.transactionExpense = transactionExpense;
    return AddExpenseScreen(expenseType: expenseType);
  }
}
