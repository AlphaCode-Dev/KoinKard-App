import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/views/assets/assets_viewmodel.dart';

class AssetsTabSwitcher extends StatelessWidget {
  const AssetsTabSwitcher({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  final AssetsTabType activeTab;
  final ValueChanged<AssetsTabType> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AssetTabLabel(
          label: 'Asset',
          isActive: activeTab == AssetsTabType.asset,
          onTap: () => onTabChanged(AssetsTabType.asset),
        ),
        const SizedBox(width: 26),
        _AssetTabLabel(
          label: 'Account',
          isActive: activeTab == AssetsTabType.account,
          onTap: () => onTabChanged(AssetsTabType.account),
        ),
        const Spacer(),
        Icon(
          Icons.pie_chart_outline_rounded,
          color: kWhiteColor.withValues(alpha: 0.42),
          size: 23,
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.hexagon_outlined,
          color: kWhiteColor.withValues(alpha: 0.9),
          size: 24,
        ),
      ],
    );
  }
}

class _AssetTabLabel extends StatelessWidget {
  const _AssetTabLabel({
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
      child: Text(
        label,
        style: AppTextStyles.headingXSmall.copyWith(
          color: isActive ? kWhiteColor : kWhiteColor.withValues(alpha: 0.34),
          fontSize: 16,
        ),
      ),
    );
  }
}
