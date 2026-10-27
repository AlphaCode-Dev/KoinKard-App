import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class SellGiftcardFooter extends StatelessWidget {
  const SellGiftcardFooter(
      {super.key,
      required this.payout,
      required this.isSubmitting,
      required this.onConfirm});

  final String payout;
  final bool isSubmitting;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lightGradientTop,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
              color: AppColors.rateTileShadow,
              blurRadius: 20,
              offset: Offset(0, -4))
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You'll Receive",
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.balanceLabel)),
                  const SizedBox(height: 8),
                  Text('\u20a6$payout',
                      style: AppTextStyles.headingSmall
                          .copyWith(color: AppColors.primary)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                minimumSize: const Size(128, 54),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: onConfirm,
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: AppColors.white))
                  : Text('Confirm', style: AppTextStyles.paragraphMediumBold),
            ),
          ],
        ),
      ),
    );
  }
}
