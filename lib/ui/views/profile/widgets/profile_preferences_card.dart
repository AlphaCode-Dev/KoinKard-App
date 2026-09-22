import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class ProfilePreferencesCard extends StatelessWidget {
  const ProfilePreferencesCard({
    super.key,
    required this.biometricsEnabled,
    required this.priceAlertsEnabled,
    required this.onBiometricsChanged,
    required this.onPriceAlertsChanged,
  });

  final bool biometricsEnabled;
  final bool priceAlertsEnabled;
  final ValueChanged<bool> onBiometricsChanged;
  final ValueChanged<bool> onPriceAlertsChanged;

  @override
  Widget build(BuildContext context) {
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
            'Preferences',
            style: AppTextStyles.headingXSmall.copyWith(
              color: kWhiteColor,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 16),
          _PreferenceTile(
            icon: Icons.fingerprint_rounded,
            title: 'Biometric unlock',
            subtitle: 'Use fingerprint or face unlock for faster access.',
            value: biometricsEnabled,
            onChanged: onBiometricsChanged,
          ),
          const SizedBox(height: 12),
          _PreferenceTile(
            icon: Icons.notifications_active_outlined,
            title: 'Price alerts',
            subtitle: 'Receive updates on major market movements.',
            value: priceAlertsEnabled,
            onChanged: onPriceAlertsChanged,
          ),
        ],
      ),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  const _PreferenceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kWhiteColor.withValues(alpha: 0.04),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kOrangeColor.withValues(alpha: 0.14),
            ),
            child: Icon(
              icon,
              color: kOrangeColor,
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
                    color: kWhiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: kWhiteColor.withValues(alpha: 0.56),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: kOrangeColor,
            activeTrackColor: kOrangeColor.withValues(alpha: 0.35),
            inactiveThumbColor: kWhiteColor.withValues(alpha: 0.72),
            inactiveTrackColor: kWhiteColor.withValues(alpha: 0.16),
          ),
        ],
      ),
    );
  }
}
