import 'package:flutter/material.dart';
import 'package:koinkard/common/app_colors.dart';
import 'package:koinkard/common/app_textstyles.dart';

class AssetOverviewCard extends StatelessWidget {
  const AssetOverviewCard({
    super.key,
    required this.selectedCurrency,
    required this.supportedCurrencies,
    required this.assetAmount,
    required this.pnlAmount,
    required this.pnlPercent,
    required this.onCurrencyChanged,
  });

  final String selectedCurrency;
  final List<String> supportedCurrencies;
  final String assetAmount;
  final String pnlAmount;
  final String pnlPercent;
  final ValueChanged<String?> onCurrencyChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: AppColors.elevatedSurface,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.12,
              child: CustomPaint(
                painter: const VerticalStripePainter(),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Total Assets',
                                    style:
                                        AppTextStyles.paragraphSmall.copyWith(
                                      color: AppColors.textPrimary.withValues(
                                        alpha: 0.48,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.visibility_outlined,
                                    size: 18,
                                    color: AppColors.textPrimary
                                        .withValues(alpha: 0.36),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            _CurrencyDropdown(
                              value: selectedCurrency,
                              items: supportedCurrencies,
                              onChanged: onCurrencyChanged,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: assetAmount,
                                style: AppTextStyles.walletBalance
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                              TextSpan(
                                text: ' $selectedCurrency',
                                style: AppTextStyles.paragraphMediumMedium
                                    .copyWith(
                                        color: AppColors.textPrimary
                                            .withValues(alpha: 0.55)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Today's P&L  $pnlAmount $selectedCurrency ($pnlPercent)",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.62),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.primary,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Deposit',
                      style: AppTextStyles.paragraphMediumBold
                          .copyWith(color: AppColors.background),
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

class _CurrencyDropdown extends StatelessWidget {
  const _CurrencyDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.textPrimary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.08),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          dropdownColor: AppColors.actionSurface,
          borderRadius: BorderRadius.circular(16),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textPrimary.withValues(alpha: 0.70),
            size: 20,
          ),
          style: AppTextStyles.paragraphSmallBold
              .copyWith(color: AppColors.textPrimary),
          items: items
              .map(
                (currency) => DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class VerticalStripePainter extends CustomPainter {
  const VerticalStripePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    for (double x = 8; x < size.width; x += 18) {
      canvas.drawLine(
        Offset(x, 12),
        Offset(x, size.height - 12),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
