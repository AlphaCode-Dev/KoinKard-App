import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class RatesBalanceSection extends StatelessWidget {
  const RatesBalanceSection({
    super.key,
    required this.refreshCountdown,
  });

  final String refreshCountdown;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Refresh rates in',
                    style: AppTextStyles.paragraphMedium.copyWith(
                      color: AppColors.textPrimary.withValues(alpha: 0.42),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.refresh_rounded,
                    color: AppColors.textPrimary.withValues(alpha: 0.36),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      refreshCountdown,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.ratesBalance
                          .copyWith(color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.balanceSurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.textPrimary.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Icon(
                      Icons.timer_outlined,
                      size: 18,
                      color: AppColors.textPrimary.withValues(alpha: 0.76),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 18),
        Container(
          width: 108,
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.transparent,
                AppColors.primary.withValues(alpha: 0.08),
                AppColors.primary.withValues(alpha: 0.90),
              ],
              stops: const [0, 0.58, 1],
            ),
          ),
        ),
      ],
    );
  }
}
