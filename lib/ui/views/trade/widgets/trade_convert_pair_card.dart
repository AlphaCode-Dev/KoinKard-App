import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
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
                color: kWhiteColor.withValues(alpha: 0.12),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF101112),
                border: Border.all(
                  color: kWhiteColor.withValues(alpha: 0.12),
                ),
              ),
              child: IconButton(
                onPressed: onSwapTap,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.swap_vert_rounded,
                  color: kWhiteColor.withValues(alpha: 0.86),
                  size: 21,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: kWhiteColor.withValues(alpha: 0.12),
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
                style: AppTextStyles.paragraphMedium.copyWith(
                  color: kWhiteColor.withValues(alpha: 0.36),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (showAvailableBalance)
                Row(
                  children: [
                    Text(
                      'Available balance: ${asset.availableBalance}',
                      style: AppTextStyles.paragraphSmall.copyWith(
                        color: kWhiteColor.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: kWhiteColor.withValues(alpha: 0.48),
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
                    _AssetCoinBadge(color: Color(asset.colorHex)),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              asset.symbol,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.headingXSmall.copyWith(
                                color: kWhiteColor,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: kWhiteColor,
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
                        style: AppTextStyles.headingSmall.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.18),
                          fontSize: 22,
                        ),
                      ),
                      if (asset.trailingLabel != '--')
                        TextSpan(
                          text: ' ${asset.trailingLabel}',
                          style: AppTextStyles.paragraphLarge.copyWith(
                            color: kOrangeColor,
                            fontWeight: FontWeight.w700,
                          ),
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
              color: kWhiteColor.withValues(alpha: 0.18),
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
        color: Colors.white,
      ),
    );
  }
}
