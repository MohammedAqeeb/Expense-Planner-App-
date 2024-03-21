import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'manager.dart';
import 'provider.dart';

class TransactionSortingLogic {
  /// Function to get get ExpenseList
  ///
  /// * [manager] to get the date from the user
  /// * [ref] to get instance of TransactionSortingService
  ///
  static Future<void> getExpenseList(
    TransactionSortedManager manager,
    WidgetRef ref,
  ) async {
    print('logic called');
    final transServicePr = ref.read(transactionSortingServicePr);

    await transServicePr.getRecentexpenseList(
      addedBefore: manager.getAddedBefore(),
    );
  }

  /// Function to get repeated list
  ///
  static Future<void> repeatGetList(
    WidgetRef ref,
  ) async {
    final transServicePr = ref.read(transactionSortingServicePr);
    await transServicePr.repeatGetList();
  }

  /// Function to scroll list of dishes
  ///
  static Future<void> getListInfiniteScroll(
    WidgetRef ref, {
    ScrollController? scrollController,
  }) async {
    scrollController!.addListener(
      () async {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        if (maxScroll - currentScroll == 0) {
          await repeatGetList(ref);
        }
      },
    );
  }
}
