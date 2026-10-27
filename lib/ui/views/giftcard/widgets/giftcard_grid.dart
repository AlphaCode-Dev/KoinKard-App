import 'package:flutter/material.dart';
import 'package:koinkard/common/app_assets.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/striped_background.dart';

import '../sell/sell_giftcard_view.dart';

class GiftcardGrid extends StatelessWidget {
  const GiftcardGrid({super.key, required this.cards});

  final List<String> cards;

  @override
  Widget build(BuildContext context) {
    return StripedBackground(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 164,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) => _GiftcardTile(name: cards[index]),
      ),
    );
  }
}

class _GiftcardTile extends StatelessWidget {
  const _GiftcardTile({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => SellGiftcardView.open(context, name),
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.actionSurface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.textPrimary.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    AppAssets.popularGiftCard,
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.paragraphSmallBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
