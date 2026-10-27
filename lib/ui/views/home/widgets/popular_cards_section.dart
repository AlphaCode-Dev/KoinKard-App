import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

import '../models/popular_card.dart';
import '../../giftcard/sell/sell_giftcard_view.dart';

class PopularCardsSection extends StatelessWidget {
  const PopularCardsSection({super.key, required this.cards});

  final List<PopularCard> cards;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Popular Cards',
                style: AppTextStyles.sectionHeading.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              'See all',
              style: AppTextStyles.paragraphSmallBold.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(height: 1, color: AppColors.textPrimary.withValues(alpha: 0.1)),
        for (final card in cards) ...[
          _PopularCardRow(card: card),
          Divider(
            height: 1,
            color: AppColors.textPrimary.withValues(alpha: 0.1),
          ),
        ],
      ],
    );
  }
}

class _PopularCardRow extends StatelessWidget {
  const _PopularCardRow({required this.card});

  final PopularCard card;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => SellGiftcardView.open(context, card.name),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                AppAssets.popularGiftCard,
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      card.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.paragraphMediumBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.textPrimary.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              card.rate,
              style: AppTextStyles.paragraphMediumBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              Icons.sort_rounded,
              size: 22,
              color: AppColors.textPrimary.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
