// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionExpense _$TransactionExpenseFromJson(Map<String, dynamic> json) =>
    TransactionExpense(
      id: json['id'] as String,
      expenseCategory: json['expenseCategory'] as String? ?? '',
      expenseDescription: json['expenseDescription'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      addedOn: DateTime.parse(json['addedOn'] as String),
      isRemoved: json['isRemoved'] as bool? ?? false,
    );

Map<String, dynamic> _$TransactionExpenseToJson(TransactionExpense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expenseCategory': instance.expenseCategory,
      'expenseDescription': instance.expenseDescription,
      'amount': instance.amount,
      'addedOn': instance.addedOn.toIso8601String(),
      'isRemoved': instance.isRemoved,
    };
