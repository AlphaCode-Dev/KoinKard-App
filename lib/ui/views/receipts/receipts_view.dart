import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:stacked/stacked.dart';

import 'receipts_viewmodel.dart';
import 'widgets/recent_transaction_row.dart';

class ReceiptsView extends StackedView<ReceiptsViewModel> {
  const ReceiptsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ReceiptsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        title: Text('Receipts', style: AppTextStyles.sectionHeading),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          itemCount: viewModel.recentTransactions.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  'Recent Transactions',
                  style: AppTextStyles.sectionHeading.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }
            return RecentTransactionRow(
              transaction: viewModel.recentTransactions[index - 1],
            );
          },
          separatorBuilder: (context, index) => index == 0
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(left: 82),
                  child: Divider(
                    height: 1,
                    color: AppColors.textPrimary.withValues(alpha: 0.06),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  ReceiptsViewModel viewModelBuilder(BuildContext context) =>
      ReceiptsViewModel();
}
