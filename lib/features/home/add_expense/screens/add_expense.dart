import 'package:expense_planner_app/core/theme/app_pallete.dart';
import 'package:expense_planner_app/features/home/add_expense/managers.dart';
import 'package:expense_planner_app/features/home/add_expense/picker.dart';
import 'package:expense_planner_app/features/home/add_expense/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../logic.dart';
import 'widgets/expense_textfield.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  final TransactionExpenseType expenseType;
  const AddExpenseScreen({
    super.key,
    required this.expenseType,
  });

  @override
  AddExpenseScreenState createState() => AddExpenseScreenState();
}

class AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();

  late ExpenseManager manager;

  @override
  void initState() {
    manager = ref.read(expenseManagerPr);
    if (widget.expenseType == TransactionExpenseType.edit &&
        manager.transactionExpense != null) {
      manager.docId = manager.transactionExpense!.id;
      manager.setExpenseAmount(manager.transactionExpense!.amount.toString());
      manager.setExpenseCategory(manager.transactionExpense!.expenseCategory);
      manager.setExpenseDescription(
          manager.transactionExpense!.expenseDescription);
      manager.setCreatedDate(manager.transactionExpense!.addedOn);
    }
    super.initState();
  }

  int value = 0;
  String startDate = 'Today';

  final items = [
    "Entertainment",
    "Food",
    "Travel",
    "Shopping",
    "Health",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: buildBody(context),
        floatingActionButton: buildFab(),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.expenseType == TransactionExpenseType.add
                    ? 'Add your expense'
                    : 'Edit expense details',
                style: const TextStyle(
                  fontSize: 22,
                  color: AppPallete.redColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              buildAmountField(),
              const SizedBox(height: 18),
              buildCategoryPicker(),
              const SizedBox(height: 18),
              buildDateField(context),
              const SizedBox(height: 18),
              buildDescriptionField(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAmountField() {
    return ExpenseTextField(
      keyboardType: TextInputType.number,
      initialValue: manager.getExpenseAmount(),
      onChanged: manager.setExpenseAmount,
      hintText: 'Amount',
      iconData: FontAwesomeIcons.indianRupeeSign,
    );
  }

  Widget buildCategoryPicker() {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker();
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppPallete.backgroundColor,
            border: Border.all(
              width: 3,
              color: AppPallete.greyColor,
            )),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  FontAwesomeIcons.list,
                  color: AppPallete.whiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  manager.getExpenseCategory() ?? 'Select Category',
                  style: const TextStyle(
                    color: AppPallete.whiteColor,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: AppPallete.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPicker() {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: AppPallete.redColor2,
      child: GestureDetector(
        onTap: () {},
        child: SafeArea(
          top: false,
          child: _buildCupertinoPicker(),
        ),
      ),
    );
  }

  Widget _buildCupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: AppPallete.redColor2,
      itemExtent: 50,
      children: items
          .map((item) => Center(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.whiteColor,
                  ),
                ),
              ))
          .toList(),
      onSelectedItemChanged: (index) {
        setState(() => value = index);
        manager.setExpenseCategory(items[index]);
      },
    );
  }

  Widget buildDateField(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppPallete.backgroundColor,
            border: Border.all(
              width: 3,
              color: AppPallete.greyColor,
            )),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  FontAwesomeIcons.calendar,
                  color: AppPallete.whiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.expenseType == TransactionExpenseType.add
                      ? startDate
                      : DateFormat('dd MMM yyyy')
                          .format(manager.getCreatedDate()),
                  style: const TextStyle(
                    color: AppPallete.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: manager.getCreatedDate(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 10)),
    );
    if (picked != null && picked != manager.getCreatedDate()) {
      setState(() {
        manager.setCreatedDate(picked);
        startDate = DateFormat('dd MMM yyyy').format(manager.getCreatedDate());
      });
    }
  }

  Widget buildDescriptionField() {
    return ExpenseTextField(
      initialValue: manager.getExpenseDescription(),
      onChanged: manager.setExpenseDescription,
      hintText: 'Description',
      iconData: FontAwesomeIcons.noteSticky,
    );
  }

  Widget buildFab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildLine(),
        buildButtons(),
      ],
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(120, 45),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              fixedSize: const Size(120, 45),
              backgroundColor: AppPallete.lightRedColor),
          onPressed: () {
            AddExpenseLogic.addOrEditExpenseTransaction(
              manager: manager,
              expenseType: widget.expenseType,
              ref: ref,
              context: context,
            );
            Navigator.pop(context);
          },
          child: Text(
            widget.expenseType == TransactionExpenseType.add
                ? 'Save'
                : 'Update',
            style: const TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, bottom: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.6,
            color: AppPallete.greyColor,
          ),
        ),
      ),
    );
  }
}
