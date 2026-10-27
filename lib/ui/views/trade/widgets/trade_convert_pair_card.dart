import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/views/trade/trade_viewmodel.dart';

class TradeConvertPairCard extends StatelessWidget {
  const TradeConvertPairCard({
    super.key,
    required this.fromAsset,
    required this.toAsset,
    required this.onSwapTap,
  });

  final TradeAssetData fromAsset;
  final TradeAssetData toAsset;
  final VoidCallback onSwapTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TradePairBlock(
          label: 'From',
          asset: fromAsset,
          showAvailableBalance: true,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.textPrimary.withValues(alpha: 0.12),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.cardSurface,
                border: Border.all(
                  color: AppColors.textPrimary.withValues(alpha: 0.12),
                ),
              ),
              child: IconButton(
                onPressed: onSwapTap,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.swap_vert_rounded,
                  color: AppColors.textPrimary.withValues(alpha: 0.86),
                  size: 21,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.textPrimary.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _TradePairBlock(
          label: 'To',
          asset: toAsset,
        ),
      ],
    );
  }
}

class _TradePairBlock extends StatelessWidget {
  const _TradePairBlock({
    required this.label,
    required this.asset,
    this.showAvailableBalance = false,
  });

  final String label;
  final TradeAssetData asset;
  final bool showAvailableBalance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppTextStyles.paragraphMediumMedium.copyWith(
                    color: AppColors.textPrimary.withValues(alpha: 0.36)),
              ),
              const Spacer(),
              if (showAvailableBalance)
                Row(
                  children: [
                    Text(
                      'Available balance: ${asset.availableBalance}',
                      style: AppTextStyles.paragraphSmallMedium.copyWith(
                          color: AppColors.textPrimary.withValues(alpha: 0.7)),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textPrimary.withValues(alpha: 0.48),
                      size: 18,
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _AssetCoinBadge(color: asset.color),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              asset.symbol,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.compactHeading
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Flexible(
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: asset.amountDisplay,
                        style: AppTextStyles.smallCardHeading.copyWith(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.18)),
                      ),
                      if (asset.trailingLabel != '--')
                        TextSpan(
                          text: ' ${asset.trailingLabel}',
                          style: AppTextStyles.paragraphLargeBold
                              .copyWith(color: AppColors.primary),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            asset.trailingLabel == '--' ? '--' : '',
            style: AppTextStyles.headingSmall.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.18),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetCoinBadge extends StatelessWidget {
  const _AssetCoinBadge({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: const Icon(
        Icons.currency_bitcoin_rounded,
        size: 17,
        color: AppColors.white,
      ),
    );
  }
}
