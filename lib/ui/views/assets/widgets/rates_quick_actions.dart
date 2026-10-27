import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class RatesQuickActions extends StatelessWidget {
  const RatesQuickActions({super.key});

  static const _actions = [
    _AssetActionData(
      label: 'Deposit',
      icon: Icons.south_west_rounded,
      highlighted: true,
    ),
    _AssetActionData(
      label: 'Withdraw',
      icon: Icons.north_east_rounded,
    ),
    _AssetActionData(
      label: 'Transfer',
      icon: Icons.sync_alt_rounded,
    ),
    _AssetActionData(
      label: 'Convert',
      icon: Icons.autorenew_rounded,
    ),
    _AssetActionData(
      label: 'Earn',
      icon: Icons.savings_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _actions
          .map(
            (action) => Expanded(
              child: _AssetActionItem(action: action),
            ),
          )
          .toList(),
    );
  }
}

class _AssetActionItem extends StatelessWidget {
  const _AssetActionItem({required this.action});

  final _AssetActionData action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: action.highlighted
                ? AppColors.primary
                : AppColors.actionSurface,
          ),
          child: Icon(
            action.icon,
            color: action.highlighted
                ? AppColors.background
                : AppColors.textPrimary,
            size: 26,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          action.label,
          textAlign: TextAlign.center,
          style: AppTextStyles.paragraphSmallMedium
              .copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _AssetActionData {
  const _AssetActionData({
    required this.label,
    required this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData icon;
  final bool highlighted;
}
