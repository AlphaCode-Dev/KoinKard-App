import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF191715),
            Color(0xFF111214),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const RadialGradient(
                colors: [
                  Color(0xFFFFB36A),
                  Color(0xFF45240B),
                  Colors.transparent,
                ],
              ),
            ),
            child: const Icon(
              Icons.public_rounded,
              color: kWhiteColor,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Events',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: kWhiteColor.withValues(alpha: 0.42),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'KoinKard Galaxy: trade more, earn more.',
                  style: AppTextStyles.paragraphLarge.copyWith(
                    color: kWhiteColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: kWhiteColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '5/5',
              style: AppTextStyles.labelXSmall.copyWith(
                color: kWhiteColor.withValues(alpha: 0.82),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
