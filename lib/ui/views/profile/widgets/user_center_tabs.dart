import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/profile/profile_viewmodel.dart';

class UserCenterTabs extends StatelessWidget {
  const UserCenterTabs({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final UserCenterTab activeTab;
  final ValueChanged<UserCenterTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TabItem(
          label: 'My info',
          isActive: activeTab == UserCenterTab.myInfo,
          onTap: () => onTabSelected(UserCenterTab.myInfo),
        ),
        const SizedBox(width: 22),
        _TabItem(
          label: 'Security',
          isActive: activeTab == UserCenterTab.security,
          onTap: () => onTabSelected(UserCenterTab.security),
        ),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.profileTab(active: isActive).copyWith(
                color: isActive
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withValues(alpha: 0.28)),
          ),
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 78,
            height: 3,
            color: isActive ? AppColors.textPrimary : AppColors.transparent,
          ),
        ],
      ),
    );
  }
}
