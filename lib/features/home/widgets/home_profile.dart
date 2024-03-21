import 'package:expense_planner_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class HomeProfileCard extends StatelessWidget {
  const HomeProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPallete.transparentColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: 20,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            child: CircleAvatar(
              backgroundColor: AppPallete.appBackgroundColor,
              radius: 24,
              child: const Icon(Icons.person),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Mohammed Aqeeb',
              style: TextStyle(
                color: AppPallete.buttonColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter Developer',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppPallete.greyColor,
                      ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
