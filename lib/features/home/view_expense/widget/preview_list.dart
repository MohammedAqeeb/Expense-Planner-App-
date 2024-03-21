import 'package:expense_planner_app/features/home/add_expense/provider.dart';
import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'preview.dart';

class ExpensePreviewList extends ConsumerWidget {
  const ExpensePreviewList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensePr$ = ref.watch(expenseList$(6));

    return expensePr$.when(
      data: (expenseList) {
        if (expenseList.isNotEmpty) {
          return _buildPreviewList(context, expenseList);
        } else if (expenseList.isEmpty) {
          return _buildListEmpty(context);
        } else {
          return _buildListEmpty(context);
        }
      },
      error: (_, __) => const SizedBox(),
      loading: () => _buildLoader(context),
    );
  }

  Widget _buildPreviewList(
    BuildContext context,
    List<TransactionExpense> expense,
  ) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        TransactionExpense transactionExpense = expense[index];
        return ExpensePreviewScreen(
          expense: transactionExpense,
        );
      },
      itemCount: expense.length,
    );
  }

  Widget _buildListEmpty(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32 * 6,
      ),
      child: Center(
        child: Text(
          'No Transactions.',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 32,
      ),
      child: Center(
        child: Text(
          'Loading...',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
