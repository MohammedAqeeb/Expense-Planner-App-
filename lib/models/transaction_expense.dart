import 'package:json_annotation/json_annotation.dart';

part 'transaction_expense.g.dart';

@JsonSerializable()
class TransactionExpense {
  String id;
  @JsonKey(defaultValue: '')
  final String expenseCategory, expenseDescription;

  @JsonKey(defaultValue: 0)
  final double amount;

  final DateTime addedOn;

  @JsonKey(defaultValue: false)
  final bool isRemoved;

  TransactionExpense({
    required this.id,
    required this.expenseCategory,
    required this.expenseDescription,
    required this.amount,
    required this.addedOn,
    required this.isRemoved,
  });

  factory TransactionExpense.fromJson(Map<String, dynamic> json) =>
      _$TransactionExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionExpenseToJson(this);
}
