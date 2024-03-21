import 'package:flutter/material.dart';

import '../../../core/theme/app_pallete.dart';

class HomePreviewList extends StatelessWidget {
  const HomePreviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 32, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Transactions',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppPallete.greyColor),
          ),
        ],
      ),
    );
  }
}
