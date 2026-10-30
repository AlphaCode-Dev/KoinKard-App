import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class TransferOptionCard extends StatelessWidget {
  const TransferOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.badge,
    this.badgeColor,
    this.badgeBorderColor,
    this.badgeTextColor = AppColors.darkText,
  });

  final String title;
  final String subtitle;
  final Widget icon;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeBorderColor;
  final Color badgeTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.rateTileBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.lightGradientMiddle,
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    Text(title,
                        style: AppTextStyles.paragraphLarge
                            .copyWith(color: AppColors.darkText)),
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                              color:
                                  badgeBorderColor ?? AppColors.rateTileBorder),
                        ),
                        child: Text(badge!,
                            style: AppTextStyles.labelXSmall
                                .copyWith(color: badgeTextColor)),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.balanceLabel, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.darkText, size: 24),
        ],
      ),
    );
  }
}
