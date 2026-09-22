import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class GiftcardBenefitsStrip extends StatelessWidget {
  const GiftcardBenefitsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Verified rates', Icons.verified_user_outlined),
      ('Fast payouts', Icons.flash_on_outlined),
      ('Fraud checks', Icons.shield_outlined),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF101112),
        border: Border.all(
          color: kWhiteColor.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: items
            .map(
              (item) => Expanded(
                child: _BenefitItem(
                  label: item.$1,
                  icon: item.$2,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  const _BenefitItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kOrangeColor.withValues(alpha: 0.14),
          ),
          child: Icon(
            icon,
            color: kOrangeColor,
            size: 22,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelXSmall.copyWith(
            color: kWhiteColor.withValues(alpha: 0.72),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
