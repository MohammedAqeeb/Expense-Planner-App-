import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:flutter/material.dart';

class TransactionSortingService with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late Query _query;
  int perPage = 10;
  late DocumentSnapshot _lastDocument;
  List<TransactionExpense> expenseDocList = [];
  bool gettingMore = false;
  bool moreAvailable = true;
  bool loading = true;

  /// Function to search expense based on these value
  ///
  Future<void> getRecentexpenseList({
    required DateTime addedBefore,
  }) async {
    print('Service called');
    print(addedBefore);

    // Resetting all values
    // print(addedBefore.add(const Duration(hours: 24)));

    expenseDocList.clear();
    gettingMore = false;
    moreAvailable = true;
    loading = true;
    notifyListeners();

    _query = _db
        .collection('expense')
        .orderBy('addedOn', descending: false)
        // .where('addedOn', isLessThanOrEqualTo: addedBefore)
        .limit(perPage);

    // Getting documents from query
    await _query.get().then((querySnapshot) {
      _firestoreToexpense(querySnapshot.docs);
    });

    loading = false;
    notifyListeners();
  }

  Future<void> repeatGetList() async {
    if (moreAvailable == false) {
      return;
    }
    if (gettingMore == true) {
      return;
    }
    gettingMore = true;
    Query getMoreQuery = _query.startAfterDocument(_lastDocument);
    await getMoreQuery.get().then(
      (querySnapshot) {
        _firestoreToexpense(querySnapshot.docs);
      },
    );
    gettingMore = false;
    notifyListeners();
  }

  void _firestoreToexpense(List<DocumentSnapshot> documents) {
    if (documents.isEmpty) {
      moreAvailable = false;
    } else if (documents.isNotEmpty) {
      if (documents.length < perPage) {
        moreAvailable = false;
      }
      for (var document in documents) {
        expenseDocList.add(
          TransactionExpense.fromJson(
            document.data() as Map<String, dynamic>,
          ),
        );
      }
      _lastDocument = documents[documents.length - 1];
    }
  }
}
