import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/views/trade/trade_viewmodel.dart';

class TradeConvertModeTabs extends StatelessWidget {
  const TradeConvertModeTabs({
    super.key,
    required this.activeMode,
    required this.onModeSelected,
  });

  final TradeConvertMode activeMode;
  final ValueChanged<TradeConvertMode> onModeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ModeLabel(
          label: 'Instant',
          isActive: activeMode == TradeConvertMode.instant,
          onTap: () => onModeSelected(TradeConvertMode.instant),
        ),
        const SizedBox(width: 24),
        _ModeLabel(
          label: 'Limit',
          isActive: activeMode == TradeConvertMode.limit,
          onTap: () => onModeSelected(TradeConvertMode.limit),
        ),
        const Spacer(),
        _ModeIcon(icon: Icons.insert_chart_outlined_rounded),
        const SizedBox(width: 14),
        _ModeIcon(icon: Icons.help_outline_rounded),
        const SizedBox(width: 14),
        _ModeIcon(icon: Icons.receipt_long_outlined),
      ],
    );
  }
}

class _ModeLabel extends StatelessWidget {
  const _ModeLabel({
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
          fontSize: 16,
          color: isActive ? kWhiteColor : kWhiteColor.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

class _ModeIcon extends StatelessWidget {
  const _ModeIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 22,
      color: kWhiteColor.withValues(alpha: 0.56),
    );
  }
}
