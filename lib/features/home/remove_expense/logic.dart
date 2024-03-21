import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../add_expense/provider.dart';

class RemoveExpenseLogic {
  /// Function to add or edit expense details based on flowType
  ///
  /// * [docId] docId of the expense to be removed
  /// * [ref] to read expenseServices
  /// * [context] to display success message on failure
  ///
  ///
  static Future<void> removeExpense({
    required String docId,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final service = ref.read(expenseServicePr);
    await service.removeExpense(
      docId: docId,
      removedTrue: true,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('expense record has been deleted'),
          ),
        );
      },
      onFailure: () {},
    );
  }
}
