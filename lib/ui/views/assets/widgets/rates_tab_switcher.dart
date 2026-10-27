import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/assets/rates_viewmodel.dart';

class RatesTabSwitcher extends StatelessWidget {
  const RatesTabSwitcher({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  final RatesTabType activeTab;
  final ValueChanged<RatesTabType> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AssetTabLabel(
          label: 'Rates',
          isActive: activeTab == RatesTabType.rates,
          onTap: () => onTabChanged(RatesTabType.rates),
        ),
        const SizedBox(width: 26),
        _AssetTabLabel(
          label: 'Calculator',
          isActive: activeTab == RatesTabType.calculator,
          onTap: () => onTabChanged(RatesTabType.calculator),
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
        style: AppTextStyles.tabHeading.copyWith(
            color: isActive
                ? AppColors.textPrimary
                : AppColors.textPrimary.withValues(alpha: 0.34)),
      ),
    );
  }
}
