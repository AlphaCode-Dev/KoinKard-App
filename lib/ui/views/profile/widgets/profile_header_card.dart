import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF141517),
            kOrangeColor.withValues(alpha: 0.20),
            const Color(0xFF0B0C0D),
          ],
        ),
        border: Border.all(color: kWhiteColor.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kWhiteColor.withValues(alpha: 0.12),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      AppAssets.kklogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AlphaCode',
                      style: AppTextStyles.headingXSmall.copyWith(
                        color: kWhiteColor,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'alphacode@koinkard.app',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: kWhiteColor.withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kWhiteColor.withValues(alpha: 0.08),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  color: kWhiteColor.withValues(alpha: 0.92),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _HeaderChip(
                  label: 'Level',
                  value: 'Verified',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _HeaderChip(
                  label: 'Wallet ID',
                  value: 'KK-2048',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _HeaderChip(
                  label: 'Tier',
                  value: 'Gold',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kWhiteColor.withValues(alpha: 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelXSmall.copyWith(
              color: kWhiteColor.withValues(alpha: 0.52),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.paragraphSmall.copyWith(
              color: kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
