import 'package:koinkard/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/assets/rates_viewmodel.dart';

class RateTile extends StatelessWidget {
  const RateTile({
    super.key,
    required this.item,
  });

  final RateItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.rateTileBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.rateTileShadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          RateBadge(item: item),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item.symbol,
              style: AppTextStyles.rateSymbol
                  .copyWith(color: AppColors.rateSymbolText),
            ),
          ),
          Text(
            '\$1 = ${item.rate}',
            style: AppTextStyles.rateValue.copyWith(color: AppColors.darkText),
          ),
        ],
      ),
    );
  }
}

class RateBadge extends StatelessWidget {
  const RateBadge({
    super.key,
    required this.item,
  });

  final RateItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: item.badgeRingColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: item.badgeColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              item.badgeText,
              style:
                  AppTextStyles.rateBadge.copyWith(color: item.badgeTextColor),
            ),
          ),
        ),
      ),
    );
  }
}
