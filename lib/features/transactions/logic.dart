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

  // Function to obtain the date from the users
  ///
  static Future selectDate(
    BuildContext context,
    TransactionSortedManager manager,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: manager.getAddedBefore(),
        firstDate: DateTime(2019, 11, 01),
        lastDate: DateTime.now());
    if (picked != null && picked != manager.getAddedBefore()) {
      manager.setAddedBefore(picked);
    }
  }
}
