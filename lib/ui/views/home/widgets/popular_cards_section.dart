import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

import '../models/popular_card.dart';
import '../../giftcard/sell/sell_giftcard_view.dart';

class PopularCardsSection extends StatelessWidget {
  const PopularCardsSection(
      {super.key, required this.cards, required this.onSeeAll});

  final List<PopularCard> cards;
  final VoidCallback onSeeAll;

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
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            InkWell(
              onTap: onSeeAll,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'See all',
                  style: AppTextStyles.paragraphSmallBold.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(height: 1, color: AppColors.textPrimary.withValues(alpha: 0.1)),
        for (final card in cards.take(5)) ...[
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            if (card.name == 'Chime' || card.name == 'Apple (iTunes)')
              _GiftCardBadge(isApple: card.name == 'Apple (iTunes)')
            else
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
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (card.name == 'Chime')
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
                fontSize: 15,
                fontWeight: FontWeight.w600,
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

class _GiftCardBadge extends StatelessWidget {
  const _GiftCardBadge({required this.isApple});

  final bool isApple;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFEDEDED),
      ),
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: -0.28,
        child: Container(
          width: 32,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: const LinearGradient(
              colors: [Color(0xFF555555), Color(0xFF222222)],
            ),
            border: Border.all(color: Colors.white, width: 0.7),
          ),
          alignment: Alignment.center,
          child: isApple
              ? const Icon(Icons.apple, size: 16, color: Colors.white)
              : const Text('Chime',
                  style: TextStyle(
                      fontSize: 5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
