import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class UserCenterProfileIntro extends StatelessWidget {
  const UserCenterProfileIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF111214),
                border: Border.all(
                  color: kWhiteColor.withValues(alpha: 0.08),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.kklogo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AlphaCode',
                    style: AppTextStyles.headingMedium.copyWith(
                      color: kWhiteColor,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: kWhiteColor.withValues(alpha: 0.08),
                    ),
                    child: Text(
                      'Site: KoinKard Global',
                      style: AppTextStyles.labelXSmall.copyWith(
                        color: kWhiteColor.withValues(alpha: 0.78),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xFF0E0F10),
            border: Border.all(color: kWhiteColor.withValues(alpha: 0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.32),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'KoinKard Protect',
                    style: AppTextStyles.headingXSmall.copyWith(
                      color: kWhiteColor,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.help_outline_rounded,
                    color: kWhiteColor.withValues(alpha: 0.76),
                    size: 19,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Add an anti-phishing code to your KoinKard emails and SMS messages to help detect spoofing attempts.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: kWhiteColor.withValues(alpha: 0.46),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Set up anti-phishing code ->',
                style: AppTextStyles.paragraphSmall.copyWith(
                  color: kOrangeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
