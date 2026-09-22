import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_asset.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/views/profile/profile_viewmodel.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';

class UserCenterContent extends StatelessWidget {
  const UserCenterContent({
    super.key,
    required this.activeTab,
    required this.google2FaEnabled,
    required this.onGoogle2FaChanged,
  });

  final UserCenterTab activeTab;
  final bool google2FaEnabled;
  final ValueChanged<bool> onGoogle2FaChanged;

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case UserCenterTab.myInfo:
        return const _MyInfoTab();
      case UserCenterTab.security:
        return _SecurityTab(
          google2FaEnabled: google2FaEnabled,
          onGoogle2FaChanged: onGoogle2FaChanged,
        );
    }
  }
}

class _MyInfoTab extends StatelessWidget {
  const _MyInfoTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ProfileRow(
          icon: Icons.person_outline_rounded,
          title: 'Profile Picture',
          trailingAvatar: true,
        ),
        const _ProfileRow(
          icon: Icons.badge_outlined,
          title: 'Nickname',
          trailingText: 'AlphaCode',
        ),
        const _ProfileRow(
          icon: Icons.perm_identity_rounded,
          title: 'UID',
          trailingText: '75700375',
          trailingCopy: true,
        ),
        const _ProfileRow(
          icon: Icons.verified_user_outlined,
          title: 'Identity Verification',
          trailingText: 'Lv.1 Verified',
        ),
        const _ProfileRow(
          icon: Icons.workspace_premium_outlined,
          title: 'VIP level',
          trailingText: 'Non-VIP',
        ),
        const _ProfileRow(
          icon: Icons.percent_rounded,
          title: 'My Fee Rates',
        ),
        const _ProfileRow(
          icon: Icons.fact_check_outlined,
          title: 'Additional Verification',
          trailingText: '0 cases',
        ),
        const _ProfileRow(
          icon: Icons.account_tree_outlined,
          title: 'Subaccount',
        ),
        const _ProfileRow(
          icon: Icons.alternate_email_rounded,
          title: 'Link Account',
          trailingLinks: true,
        ),
        const SizedBox(height: 18),
        const KoinkardPrimaryButton(
          text: 'Log Out',
          backgroundColor: Colors.transparent,
          textColor: kWhiteColor,
          height: 56,
        ),
      ],
    );
  }
}

class _SecurityTab extends StatelessWidget {
  const _SecurityTab({
    required this.google2FaEnabled,
    required this.onGoogle2FaChanged,
  });

  final bool google2FaEnabled;
  final ValueChanged<bool> onGoogle2FaChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Basic Protect',
          subtitle: 'Essential protection for everyday account activity.',
        ),
        const SizedBox(height: 8),
        const _ProfileRow(
          icon: Icons.email_outlined,
          title: 'Email',
          trailingText: 'ade***@****',
        ),
        const _ProfileRow(
          icon: Icons.smartphone_outlined,
          title: 'Mobile',
          trailingText: '701****910',
        ),
        _ProfileSwitchRow(
          icon: Icons.g_mobiledata_rounded,
          title: 'Google 2FA Authentication',
          value: google2FaEnabled,
          onChanged: onGoogle2FaChanged,
        ),
        const _ProfileRow(
          icon: Icons.key_outlined,
          title: 'Passkeys',
        ),
        const _ProfileRow(
          icon: Icons.grid_4x4_outlined,
          title: 'Anti-phishing Code',
          trailingText: 'Not Yet Configured',
        ),
        const SizedBox(height: 22),
        const Divider(color: Color(0xFF161719), height: 1),
        const SizedBox(height: 16),
        const _SectionTitle(
          title: 'Advanced Protect',
          subtitle: 'Additional protection for key fund actions.',
        ),
        const SizedBox(height: 8),
        const _ProfileRow(
          icon: Icons.shield_outlined,
          title: 'Fund Password',
          trailingText: 'Configured',
        ),
        const _ProfileRow(
          icon: Icons.rule_folder_outlined,
          title: 'Secure Transaction Approval',
        ),
        const SizedBox(height: 22),
        const Divider(color: Color(0xFF161719), height: 1),
        const SizedBox(height: 16),
        const _SectionTitle(
          title: 'Scenario-based protection',
          subtitle: 'Extra protection for specific scenarios.',
        ),
        const SizedBox(height: 8),
        const _ProfileRow(
          icon: Icons.lock_open_outlined,
          title: 'Withdrawal Security',
        ),
        const SizedBox(height: 22),
        const Divider(color: Color(0xFF161719), height: 1),
        const SizedBox(height: 16),
        const _SectionTitle(
          title: 'Account access and management',
          subtitle: '',
        ),
        const SizedBox(height: 8),
        const _ProfileRow(
          icon: Icons.lock_outline_rounded,
          title: 'Change Password',
        ),
        const _ProfileRow(
          icon: Icons.devices_other_outlined,
          title: 'Trusted Devices',
        ),
        const _ProfileRow(
          icon: Icons.manage_accounts_outlined,
          title: 'Account Settings',
        ),
        const _ProfileRow(
          icon: Icons.lock_person_outlined,
          title: 'App Lock',
        ),
        const SizedBox(height: 18),
        Text(
          'Last login time 2026-09-22 00:14:22',
          style: AppTextStyles.bodyMedium.copyWith(
            color: kWhiteColor.withValues(alpha: 0.34),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Login device Android',
          style: AppTextStyles.bodyMedium.copyWith(
            color: kWhiteColor.withValues(alpha: 0.34),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headingXSmall.copyWith(
            color: kWhiteColor,
            fontSize: 17,
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: kWhiteColor.withValues(alpha: 0.34),
            ),
          ),
        ],
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.icon,
    required this.title,
    this.trailingText,
    this.trailingAvatar = false,
    this.trailingCopy = false,
    this.trailingLinks = false,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final bool trailingAvatar;
  final bool trailingCopy;
  final bool trailingLinks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kWhiteColor.withValues(alpha: 0.04),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: kWhiteColor,
            size: 25,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.headingXSmall.copyWith(
                color: kWhiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (trailingAvatar)
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.kklogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (trailingLinks)
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF229ED9),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: kWhiteColor.withValues(alpha: 0.12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'X',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (trailingText != null) ...[
            Text(
              trailingText!,
              style: AppTextStyles.paragraphMedium.copyWith(
                color: kWhiteColor.withValues(alpha: 0.38),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (trailingCopy) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.copy_all_outlined,
                color: kWhiteColor.withValues(alpha: 0.34),
                size: 18,
              ),
            ],
          ],
          const SizedBox(width: 10),
          Icon(
            Icons.chevron_right_rounded,
            color: kWhiteColor.withValues(alpha: 0.26),
            size: 24,
          ),
        ],
      ),
    );
  }
}

class _ProfileSwitchRow extends StatelessWidget {
  const _ProfileSwitchRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kWhiteColor.withValues(alpha: 0.04),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: kWhiteColor,
            size: 25,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.headingXSmall.copyWith(
                color: kWhiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: kOrangeColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: kWhiteColor.withValues(alpha: 0.16),
          ),
        ],
      ),
    );
  }
}
