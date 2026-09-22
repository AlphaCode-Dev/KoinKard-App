import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class ProfileSectionList extends StatelessWidget {
  const ProfileSectionList({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        'Verification',
        'Complete KYC, update identity details, and manage limits.',
        Icons.verified_outlined
      ),
      (
        'Bank Accounts',
        'Manage payout destinations and linked settlement methods.',
        Icons.account_balance_outlined
      ),
      (
        'Security Center',
        'PIN, password, trusted devices, and login activity.',
        Icons.shield_outlined
      ),
      (
        'Support',
        'Open tickets, FAQs, and direct help from KoinKard.',
        Icons.headset_mic_outlined
      ),
      ('Log Out', 'Sign out from this device securely.', Icons.logout_rounded),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF101112),
        border: Border.all(color: kWhiteColor.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account',
            style: AppTextStyles.headingXSmall.copyWith(
              color: kWhiteColor,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 14),
          ...items.asMap().entries.map((entry) {
            final item = entry.value;
            return Column(
              children: [
                _SectionRow(
                  title: item.$1,
                  subtitle: item.$2,
                  icon: item.$3,
                  isLogout: item.$1 == 'Log Out',
                ),
                if (entry.key != items.length - 1)
                  Divider(
                    height: 22,
                    color: kWhiteColor.withValues(alpha: 0.06),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isLogout,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final accent = isLogout ? const Color(0xFFFF6B6B) : kOrangeColor;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accent.withValues(alpha: 0.14),
          ),
          child: Icon(
            icon,
            color: accent,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.paragraphMedium.copyWith(
                  color: isLogout ? accent : kWhiteColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: kWhiteColor.withValues(alpha: 0.54),
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.chevron_right_rounded,
          color: kWhiteColor.withValues(alpha: 0.34),
          size: 22,
        ),
      ],
    );
  }
}
