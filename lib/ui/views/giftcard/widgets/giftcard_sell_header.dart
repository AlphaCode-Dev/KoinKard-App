import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class GiftcardSellHeader extends StatelessWidget {
  const GiftcardSellHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trade Gift Cards',
                style: AppTextStyles.headingMedium.copyWith(
                  color: kWhiteColor,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Turn unused cards into cash with secure rates and fast settlement.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: kWhiteColor.withValues(alpha: 0.62),
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kOrangeColor.withValues(alpha: 0.14),
            border: Border.all(
              color: kOrangeColor.withValues(alpha: 0.22),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kOrangeColor,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Live Rates',
                style: AppTextStyles.labelXSmall.copyWith(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
