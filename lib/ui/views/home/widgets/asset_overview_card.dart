import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

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
        color: const Color(0xFF111214),
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
                                      color: kWhiteColor.withValues(
                                        alpha: 0.48,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.visibility_outlined,
                                    size: 18,
                                    color: kWhiteColor.withValues(alpha: 0.36),
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
                                style: AppTextStyles.headingLarge.copyWith(
                                  color: kWhiteColor,
                                  fontSize: 42,
                                ),
                              ),
                              TextSpan(
                                text: ' $selectedCurrency',
                                style: AppTextStyles.paragraphMedium.copyWith(
                                  color: kWhiteColor.withValues(alpha: 0.55),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Today's P&L  $pnlAmount $selectedCurrency ($pnlPercent)",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: kWhiteColor.withValues(alpha: 0.62),
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
                      color: kOrangeColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Deposit',
                      style: AppTextStyles.paragraphMedium.copyWith(
                        color: kDarkColor,
                        fontWeight: FontWeight.w700,
                      ),
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
        color: kWhiteColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: kWhiteColor.withValues(alpha: 0.08),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          dropdownColor: const Color(0xFF17191D),
          borderRadius: BorderRadius.circular(16),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: kWhiteColor.withValues(alpha: 0.70),
            size: 20,
          ),
          style: AppTextStyles.paragraphSmall.copyWith(
            color: kWhiteColor,
            fontWeight: FontWeight.w700,
          ),
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
      ..color = kWhiteColor.withValues(alpha: 0.05)
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
