import 'package:expense_planner_app/features/home/add_expense/managers.dart';
import 'package:expense_planner_app/services/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/transaction_expense.dart';

final expenseManagerPr = Provider.autoDispose<ExpenseManager>((ref) {
  final manager = ExpenseManager();
  ref.onDispose(() {
    manager.dispose();
  });
  return manager;
});

final expenseServicePr = Provider.autoDispose<ExpenseService>((ref) {
  final service = ExpenseService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final expenseList$ = StreamProvider.autoDispose
    .family<List<TransactionExpense>, int>((ref, int limit) {
  final service = ref.watch(expenseServicePr);
  service.getExpenseRecord(limit: limit);
  return service.expenseLists$;
});
