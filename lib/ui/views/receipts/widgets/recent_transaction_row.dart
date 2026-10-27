import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

import '../models/recent_transaction.dart';

class RecentTransactionRow extends StatelessWidget {
  const RecentTransactionRow({super.key, required this.transaction});

  final RecentTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.transactionIconSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.textPrimary.withValues(alpha: 0.05),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.background.withValues(alpha: 0.22),
                  blurRadius: 16,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                transaction.icon,
                color: transaction.accentColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: AppTextStyles.paragraphMediumBold
                      .copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.54),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.amount,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.paragraphMediumBold.copyWith(
                      color: transaction.isCredit
                          ? AppColors.positive
                          : AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                Text(
                  transaction.status,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.labelXSmallBold.copyWith(
                      color: transaction.isCredit
                          ? AppColors.positive
                          : AppColors.textPrimary.withValues(alpha: 0.74)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
