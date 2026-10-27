import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class MarketSnapshotCard extends StatelessWidget {
  const MarketSnapshotCard({super.key});

  static const marketTabs = ['Favorites', 'Hot', 'New', 'Gainers', 'Losers'];
  static const segmentTabs = ['Spot', 'Futures', 'CFD', 'Alpha'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColors.elevatedSurface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _MarketTabsRow(),
          SizedBox(height: 18),
          _SegmentTabsRow(),
          SizedBox(height: 18),
          MarketRow(
            symbol: 'XRP / USDT',
            name: 'Ripple',
            volume: '112.33M',
            price: '1.5532',
            change: '+10.26%',
            leverage: '10x',
          ),
          MarketRow(
            symbol: 'BARD / USDT',
            name: 'Lombard',
            volume: '114.63K',
            price: '0.1360',
            change: '+4.37%',
            leverage: '5x',
          ),
          MarketRow(
            symbol: 'ASTER / USDT',
            name: 'Aster',
            volume: '9.76M',
            price: '0.7477',
            change: '+0.90%',
            leverage: '5x',
          ),
          MarketRow(
            symbol: 'BTC / USDT',
            name: 'Bitcoin',
            volume: '906.55M',
            price: '86,609.0',
            change: '+6.70%',
            leverage: '10x',
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _MarketTabsRow extends StatelessWidget {
  const _MarketTabsRow();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: MarketSnapshotCard.marketTabs.map((tab) {
          final isActive = tab == 'Favorites';
          return Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Text(
              tab,
              style: AppTextStyles.marketTab(active: isActive).copyWith(
                  color: isActive
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withValues(alpha: 0.34)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SegmentTabsRow extends StatelessWidget {
  const _SegmentTabsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: MarketSnapshotCard.segmentTabs.map((tab) {
        final isActive = tab == 'Spot';
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.textPrimary.withValues(alpha: 0.08)
                  : AppColors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              tab,
              style: AppTextStyles.paragraphSmall.copyWith(
                color: isActive
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withValues(alpha: 0.34),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MarketRow extends StatelessWidget {
  const MarketRow({
    super.key,
    required this.symbol,
    required this.name,
    required this.volume,
    required this.price,
    required this.change,
    required this.leverage,
    this.showDivider = true,
  });

  final String symbol;
  final String name;
  final String volume;
  final String price;
  final String change;
  final String leverage;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.14),
                ),
                child: Icon(
                  Icons.currency_bitcoin_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            symbol,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.paragraphMediumBold
                                .copyWith(color: AppColors.textPrimary),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            leverage,
                            style: AppTextStyles.labelXSmall.copyWith(
                              color:
                                  AppColors.textPrimary.withValues(alpha: 0.76),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$name | $volume',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary.withValues(alpha: 0.42),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: AppTextStyles.paragraphLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      change,
                      style: AppTextStyles.paragraphSmallBold
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.textPrimary.withValues(alpha: 0.06),
          ),
      ],
    );
  }
}
