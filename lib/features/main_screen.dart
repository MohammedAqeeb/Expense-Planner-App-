import 'package:expense_planner_app/core/theme/app_pallete.dart';
import 'package:expense_planner_app/features/home/add_expense/picker.dart';
import 'package:expense_planner_app/features/home/home_screen.dart';
import 'package:expense_planner_app/features/transactions/screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List screens = [
    const HomeScreen(),
    const TransactionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        body: screens[currentIndex],
        floatingActionButton: buildFAB(),
        bottomNavigationBar: buildBottom(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget buildFAB() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: FloatingActionButton(
        backgroundColor: AppPallete.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExpensePickerScreen(
                expenseType: TransactionExpenseType.add,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add_outlined,
          color: AppPallete.whiteColor,
        ),
      ),
    );
  }

  Widget buildBottom() {
    void tap(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(
          30,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppPallete.borderColor,
        elevation: 4,
        onTap: tap,
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppPallete.lightRedColor,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: AppPallete.whiteColor,
            activeIcon: Icon(
              Icons.home,
              color: AppPallete.redColor,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: AppPallete.greyColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppPallete.whiteColor,
            activeIcon: Icon(
              Icons.analytics_outlined,
              color: AppPallete.errorColor,
            ),
            icon: Icon(
              Icons.analytics_outlined,
              color: AppPallete.greyColor,
            ),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
