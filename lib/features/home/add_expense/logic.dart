import 'package:expense_planner_app/features/home/add_expense/managers.dart';
import 'package:expense_planner_app/features/home/add_expense/picker.dart';
import 'package:expense_planner_app/features/home/add_expense/provider.dart';
import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseLogic {
  /// Function to add or edit expense details based on flowType
  ///
  /// * [manager] contain user entered data
  /// * [flowType] either to edit or add expense
  /// * [ref] to read ExpenseService
  /// * [context] to display success message on failure
  ///
  static Future<void> addOrEditExpenseTransaction({
    required ExpenseManager manager,
    required TransactionExpenseType expenseType,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final service = ref.read(expenseServicePr);

    final TransactionExpense expense = TransactionExpense(
      id: expenseType == TransactionExpenseType.add ? '' : manager.docId,
      amount: double.parse(manager.getExpenseAmount()),
      addedOn: manager.getCreatedDate(),
      isRemoved: false,
      expenseCategory: manager.getExpenseCategory()!,
      expenseDescription: manager.getExpenseDescription(),
    );

    await service.addOrUpdateExpense(
      flowType: expenseType,
      expense: expense,
      onSuccess: () {
        if (expenseType == TransactionExpenseType.add) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added Successfully..')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Updated Successfully')));
        }
      },
      onFailure: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something Went Wrong')));
      },
    );
  }
}
