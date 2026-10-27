import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class GiftcardSellHeader extends StatelessWidget {
  const GiftcardSellHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trade Gift Cards',
          style: AppTextStyles.giftcardHeading.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Turn your unused gift cards into cash, all in one place.',
          style: AppTextStyles.sectionDescription.copyWith(
            color: AppColors.textPrimary.withValues(alpha: 0.62),
          ),
        ),
      ],
    );
  }
}
