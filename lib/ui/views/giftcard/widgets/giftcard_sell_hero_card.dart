import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class GiftcardSellHeroCard extends StatelessWidget {
  const GiftcardSellHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.giftcardGradientStart,
            AppColors.primary.withValues(alpha: 0.22),
            AppColors.cardSurface,
          ],
        ),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.06),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'High-value cards.\nInstant conversion.',
                          style: AppTextStyles.giftcardHeroHeading
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Sell Amazon, Steam, iTunes, Visa and more from one secure KoinKard trade desk.',
                          style: AppTextStyles.bodyMessage.copyWith(
                              color: AppColors.textPrimary
                                  .withValues(alpha: 0.64)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 112,
                    height: 112,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          angle: -0.22,
                          child: _MiniGiftCard(
                            color: AppColors.giftcardGradientEnd,
                            child: Image.asset(
                              AppAssets.giftcardshow,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: 0.14,
                          child: _MiniGiftCard(
                            color: AppColors.primary.withValues(alpha: 0.18),
                            child: Icon(
                              Icons.redeem_rounded,
                              color: AppColors.primary,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(
                    child: _HeroStatChip(
                      label: 'Avg payout',
                      value: '5 mins',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _HeroStatChip(
                      label: 'Best rate',
                      value: 'Up to 92%',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _HeroStatChip(
                      label: 'Supported',
                      value: '20+ brands',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniGiftCard extends StatelessWidget {
  const _MiniGiftCard({
    required this.color,
    required this.child,
  });

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 54,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color,
        border:
            Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: AppColors.background.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _HeroStatChip extends StatelessWidget {
  const _HeroStatChip({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.textPrimary.withValues(alpha: 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelXSmall.copyWith(
              color: AppColors.textPrimary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.paragraphMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
