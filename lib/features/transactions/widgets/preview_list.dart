import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/transaction_expense.dart';
import '../../home/view_expense/widget/preview.dart';
import '../provider.dart';

class TransactionSortingPreviewList extends ConsumerWidget {
  const TransactionSortingPreviewList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(transactionSortingServicePr);
    Widget returnWidget = SliverToBoxAdapter(
      child: Container(),
    );

    if (service.loading == true) {
      returnWidget = _buildLoading(context);
    } else if (service.expenseDocList.isEmpty) {
      returnWidget = _buildNoDocs(context);
    } else {
      returnWidget = _buildList(context, service.expenseDocList);
    }
    return returnWidget;
  }

  Widget _buildList(
      BuildContext context, List<TransactionExpense> transactions) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final doc = transactions[index];
          return ExpensePreviewScreen(
            expense: doc,
          );
        },
        childCount: transactions.length,
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'Loading...',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }

  Widget _buildNoDocs(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 32 * 6,
        ),
        child: Center(
          child: Text(
            'You have no transactions recorded.',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
