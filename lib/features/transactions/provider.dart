import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/transaction_sorting.dart';
import 'manager.dart';

final transactionSortedManager =
    Provider.autoDispose<TransactionSortedManager>((ref) {
  final manager = TransactionSortedManager();
  ref.onDispose(() {
    manager.dispose();
  });
  return manager;
});

final transactionSortingServicePr = ChangeNotifierProvider.autoDispose(
  (ref) => TransactionSortingService(),
);
