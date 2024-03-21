import 'package:flutter/material.dart';

import 'view_expense/widget/preview_list.dart';
import 'widgets/home_preview.dart';
import 'widgets/home_profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 32, bottom: 12, left: 8, right: 8),
        child: Column(
          children: [
            HomeProfileCard(),
            HomePreviewList(),
            ExpensePreviewList(),
          ],
        ),
      ),
    );
  }
}
