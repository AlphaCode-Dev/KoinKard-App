import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/profile/profile_viewmodel.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';

class UserCenterContent extends StatelessWidget {
  const UserCenterContent({
    super.key,
    required this.activeTab,
    required this.google2FaEnabled,
    required this.profileImagePath,
    required this.onGoogle2FaChanged,
    required this.onProfileImageTap,
  });

  final UserCenterTab activeTab;
  final bool google2FaEnabled;
  final String? profileImagePath;
  final ValueChanged<bool> onGoogle2FaChanged;
  final VoidCallback onProfileImageTap;

  @override
  Widget build(BuildContext context) {
    switch (activeTab) {
      case UserCenterTab.myInfo:
        return _MyInfoTab(
          profileImagePath: profileImagePath,
          onProfileImageTap: onProfileImageTap,
        );
      case UserCenterTab.security:
        return _SecurityTab(
          google2FaEnabled: google2FaEnabled,
          onGoogle2FaChanged: onGoogle2FaChanged,
        );
    }
  }
}

class _MyInfoTab extends StatelessWidget {
  const _MyInfoTab({
    required this.profileImagePath,
    required this.onProfileImageTap,
  });

  final String? profileImagePath;
  final VoidCallback onProfileImageTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileRow(
          icon: Icons.person_outline_rounded,
          title: 'Profile Picture',
          trailingAvatar: true,
          avatarImagePath: profileImagePath,
          onTap: onProfileImageTap,
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
          backgroundColor: AppColors.transparent,
          textColor: AppColors.textPrimary,
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
        const Divider(color: AppColors.profileDivider, height: 1),
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
        const Divider(color: AppColors.profileDivider, height: 1),
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
        const Divider(color: AppColors.profileDivider, height: 1),
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
            color: AppColors.textPrimary.withValues(alpha: 0.34),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Login device Android',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary.withValues(alpha: 0.34),
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
          style: AppTextStyles.compactHeading
              .copyWith(color: AppColors.textPrimary),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.34),
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
    this.avatarImagePath,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final bool trailingAvatar;
  final bool trailingCopy;
  final bool trailingLinks;
  final String? avatarImagePath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.textPrimary.withValues(alpha: 0.04),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textPrimary,
              size: 25,
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.profileRowTitle
                    .copyWith(color: AppColors.textPrimary),
              ),
            ),
            if (trailingAvatar)
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                ),
                child: ClipOval(
                  child: _ProfileSettingAvatar(imagePath: avatarImagePath),
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
                      color: AppColors.telegram,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: AppColors.white,
                      size: 17,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.textPrimary.withValues(alpha: 0.12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'X',
                        style: AppTextStyles.socialMark,
                      ),
                    ),
                  ),
                ],
              ),
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: AppTextStyles.paragraphMediumMedium.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.38)),
              ),
              if (trailingCopy) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.copy_all_outlined,
                  color: AppColors.textPrimary.withValues(alpha: 0.34),
                  size: 18,
                ),
              ],
            ],
            const SizedBox(width: 10),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textPrimary.withValues(alpha: 0.26),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSettingAvatar extends StatelessWidget {
  const _ProfileSettingAvatar({required this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath!.isEmpty) {
      return Image.asset(
        AppAssets.appicon,
        fit: BoxFit.contain,
      );
    }

    if (kIsWeb) {
      return Image.network(
        imagePath!,
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(imagePath!),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        AppAssets.appicon,
        fit: BoxFit.contain,
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
            color: AppColors.textPrimary.withValues(alpha: 0.04),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.textPrimary,
            size: 25,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.profileRowTitle
                  .copyWith(color: AppColors.textPrimary),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.textPrimary.withValues(alpha: 0.16),
          ),
        ],
      ),
    );
  }
}
