import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:rxdart/subjects.dart';

class ExpenseManager {
  TransactionExpense? transactionExpense;
  String docId = '';

  //-----------------------------  Subject Name declaration --------------------

  final BehaviorSubject<String> expenseAmount =
      BehaviorSubject<String>.seeded('');

  final BehaviorSubject<String?> expenseCategory =
      BehaviorSubject<String>.seeded('Select Category');

  final BehaviorSubject<String> expenseDescription =
      BehaviorSubject<String>.seeded('');

  final BehaviorSubject<DateTime> dateController =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  //---------------------------- Set method -------------------------

  void setExpenseAmount(String value) => expenseAmount.sink.add(value);
  void setExpenseCategory(String value) => expenseCategory.sink.add(value);
  void setExpenseDescription(String value) =>
      expenseDescription.sink.add(value);

  void setCreatedDate(DateTime value) => dateController.sink.add(value);

  //--------------------------- Get method --------------------------

  String getExpenseAmount() => expenseAmount.value;

  String? getExpenseCategory() => expenseCategory.value;

  String getExpenseDescription() => expenseDescription.value;

  DateTime getCreatedDate() => dateController.value;

  //------------ subject dispose ------------

  void dispose() {
    expenseAmount.close();
    expenseCategory.close();
    expenseDescription.close();
    dateController.close();
  }
}
