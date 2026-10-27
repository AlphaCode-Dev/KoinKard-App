import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class ProfileAccountStats extends StatelessWidget {
  const ProfileAccountStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(
            icon: Icons.security_rounded,
            title: 'Security',
            value: '92%',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.credit_card_rounded,
            title: 'Active cards',
            value: '04',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.swap_horiz_rounded,
            title: 'Trades',
            value: '128',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.cardSurface,
        border:
            Border.all(color: AppColors.textPrimary.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 21,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: AppTextStyles.accountStat
                .copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.labelXSmall.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.58),
            ),
          ),
        ],
      ),
    );
  }
}
