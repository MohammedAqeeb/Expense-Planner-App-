import 'package:expense_planner_app/core/theme/app_pallete.dart';
import 'package:expense_planner_app/features/transactions/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'logic.dart';
import 'provider.dart';
import 'widgets/preview_list.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends ConsumerState<TransactionScreen> {
  final ScrollController _scrollController = ScrollController();

  late TransactionSortedManager manager;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _executeSearch();
    });
  }

  Future<void> _executeSearch() async {
    return await TransactionSortingLogic.getExpenseList(manager, ref);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TransactionSortingLogic.getListInfiniteScroll(
      ref,
      scrollController: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    manager = ref.watch(transactionSortedManager);
    ref.watch(transactionSortingServicePr);

    return Scaffold(
      body: RefreshIndicator(
        child: buildStickyHeader(),
        onRefresh: () async {
          return await TransactionSortingLogic.getExpenseList(
            manager,
            ref,
          );
        },
      ),
    );
  }

  Widget buildStickyHeader() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverStickyHeader(
            header: _buildDateSelector(context),
            sliver: const TransactionSortingPreviewList(),
          )
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: manager.addedBefore$,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DateTime? addedBefore = snapshot.data;
          return Material(
            elevation: 2,
            color: AppPallete.transparentColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'BEFORE : ',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppPallete.lightGrey),
                  ),
                  Text(
                    '${addedBefore!.toLocal()}'.split(' ')[0],
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await _selectDate(context);
                      _executeSearch();
                    },
                    icon: const Icon(Icons.calendar_today),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: manager.getAddedBefore(),
        firstDate: DateTime(2019, 11, 01),
        lastDate: DateTime.now());
    if (picked != null && picked != manager.getAddedBefore()) {
      manager.setAddedBefore(picked);
    }
  }
}
