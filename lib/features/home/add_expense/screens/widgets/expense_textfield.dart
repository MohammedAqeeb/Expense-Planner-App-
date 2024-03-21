import 'package:expense_planner_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ExpenseTextField extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final Function()? onTap;
  final bool readOnly;
  final String? initialValue;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  const ExpenseTextField({
    super.key,
    required this.hintText,
    this.iconData,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppPallete.lightRedColor,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is empty';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 6, bottom: 6),
        prefixIcon: Icon(
          iconData,
          color: AppPallete.whiteColor,
          size: 18,
        ),
        labelText: hintText,
        hintStyle: const TextStyle(color: AppPallete.greyColor),
      ),
    );
  }
}
