import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:rxdart/subjects.dart';

import '../features/home/add_expense/picker.dart';

class ExpenseService {
  static final db = FirebaseFirestore.instance;

  final BehaviorSubject<List<TransactionExpense>> expenseSubject =
      BehaviorSubject<List<TransactionExpense>>();

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  /// Function to add or edit expense details based on flowType
  ///
  /// * [flowType] either to edit or add Transaction Expense
  /// * [expense] expense json model to store in firebase
  /// * [onSuccess] to display success message on screenn
  /// * [onFailure] to display success message on failure
  ///
  Future<void> addOrUpdateExpense({
    required TransactionExpenseType flowType,
    required TransactionExpense expense,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    // if the flowtype is of add then value is added on firebase
    if (flowType == TransactionExpenseType.add) {
      final ref = db.collection('expense').doc();

      expense.id = ref.id;

      await ref.set(expense.toJson()).then((value) {
        onSuccess();
      }).onError((error, stackTrace) {
        onFailure();
      });
      // if the flowtype is of edit then value is updated
    } else if (flowType == TransactionExpenseType.edit) {
      final ref = db.collection('expense').doc(expense.id);

      await ref.update(expense.toJson()).then((value) {
        onSuccess;
      }).onError((error, stackTrace) {
        onFailure;
      });
    }
  }

  /// Function to get all the expense
  ///
  void getExpenseRecord({required int limit}) {
    List<TransactionExpense> expense = [];

    streamSubscription = db
        .collection('expense')
        .orderBy('addedOn', descending: true)
        .where('isRemoved', isEqualTo: false)
        .limit(limit)
        .snapshots()
        .listen((record) {
      expense.clear();
      if (record.docs.isNotEmpty) {
        for (var doc in record.docs) {
          expense.add(TransactionExpense.fromJson(doc.data()));
          expenseSubject.sink.add(expense);
        }
      } else {
        expenseSubject.sink.add(expense);
      }
    });
  }

  Stream<List<TransactionExpense>> get expenseLists$ => expenseSubject.stream;

  /// Function to remove the current expense
  ///
  /// * [docId] docId of the expense to be removed
  /// * [removedTrue] boolean value true indicated expense removed
  /// * [onSuccess] to display success message on screenn
  /// * [onFailure] to display success message on failure
  ///
  Future<void> removeExpense({
    required String docId,
    required bool removedTrue,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    final ref = db.collection('expense').doc(docId);

    await ref.delete().then((value) => onSuccess()).onError(
          (error, stackTrace) => onFailure(),
        );

    // await ref
    //     .update(
    //       {'isRemoved': removedTrue},
    //     )
    //     .then((value) => onSuccess())
    //     .onError(
    //       (error, stackTrace) => onFailure,
    //     );
  }

  void dispose() {
    expenseSubject.close();
    streamSubscription?.cancel();
  }
}
