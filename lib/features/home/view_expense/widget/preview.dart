import 'package:expense_planner_app/core/theme/app_pallete.dart';
import 'package:expense_planner_app/models/transaction_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../add_expense/picker.dart';
import '../../remove_expense/logic.dart';

class ExpensePreviewScreen extends ConsumerStatefulWidget {
  final TransactionExpense expense;
  const ExpensePreviewScreen({super.key, required this.expense});

  @override
  ExpensePreviewScreenState createState() => ExpensePreviewScreenState();
}

class ExpensePreviewScreenState extends ConsumerState<ExpensePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          if (!widget.expense.isRemoved) {
            RemoveExpenseLogic.removeExpense(
              docId: widget.expense.id,
              ref: ref,
              context: context,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something Went Wrong')),
            );
          }
        });
      },
      child:
       buildExpenseCard(context),
    );
  }

  final Map<String, IconData> categoryIcons = const {
    'Entertainment': FontAwesomeIcons.tv,
    'Food': FontAwesomeIcons.burger,
    'Travel': FontAwesomeIcons.plane,
    'Shopping': FontAwesomeIcons.shop,
    'Health': FontAwesomeIcons.briefcaseMedical,
    'Others': Icons.list_alt_outlined,
  };

  Widget buildExpenseCard(BuildContext context) {
    IconData iconData =
        categoryIcons[widget.expense.expenseCategory] ?? Icons.category;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpensePickerScreen(
              expenseType: TransactionExpenseType.edit,
              transactionExpense: widget.expense,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppPallete.borderColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.only(top: 16.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(18),
          subtitle: Text(
            widget.expense.expenseDescription,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: AppPallete.greyColor),
          ),
          title: Text(
            textAlign: TextAlign.start,
            widget.expense.expenseCategory,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppPallete.gradient3,
                ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              iconData,
              size: 25,
              color: AppPallete.lightGrey,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                ' ${DateFormat('dd MMM yyyy').format(widget.expense.addedOn)}',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: AppPallete.greyColor),
              ),
              Text(
                '\u{20B9} ${widget.expense.amount.toString()}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.redColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
