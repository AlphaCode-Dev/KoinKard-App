import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class AssetsHeader extends StatelessWidget {
  const AssetsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kWhiteColor.withValues(alpha: 0.08)),
            color: const Color(0xFF17181C),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: ClipOval(
              child: Image.asset(
                AppAssets.kklogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  'KoinKard',
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headingXSmall.copyWith(
                    color: kWhiteColor,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: kWhiteColor.withValues(alpha: 0.85),
              ),
            ],
          ),
        ),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kWhiteColor.withValues(alpha: 0.08)),
            color: const Color(0xFF121316),
          ),
          child: Icon(
            Icons.receipt_long_rounded,
            color: kWhiteColor.withValues(alpha: 0.92),
            size: 23,
          ),
        ),
      ],
    );
  }
}
