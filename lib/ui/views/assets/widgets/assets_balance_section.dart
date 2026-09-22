import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';

class AssetsBalanceSection extends StatelessWidget {
  const AssetsBalanceSection({
    super.key,
    required this.currencies,
    required this.selectedCurrency,
    required this.selectedAmount,
    required this.selectedCryptoAmount,
    required this.selectedCryptoSymbol,
    required this.selectedPnl,
    required this.availableBalance,
    required this.inUseBalance,
    required this.onCurrencyChanged,
  });

  final List<String> currencies;
  final String selectedCurrency;
  final String selectedAmount;
  final String selectedCryptoAmount;
  final String selectedCryptoSymbol;
  final String selectedPnl;
  final String availableBalance;
  final String inUseBalance;
  final ValueChanged<String?> onCurrencyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    children: [
                      Text(
                        'Total Assets',
                        style: AppTextStyles.paragraphMedium.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.42),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.visibility_outlined,
                        color: kWhiteColor.withValues(alpha: 0.36),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          selectedAmount,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.headingLarge.copyWith(
                            color: kWhiteColor,
                            fontSize: 42,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      _BalanceCurrencyDropdown(
                        value: selectedCurrency,
                        items: currencies,
                        onChanged: onCurrencyChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        '≈ $selectedCryptoAmount $selectedCryptoSymbol',
                        style: AppTextStyles.paragraphMedium.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.48),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.help_outline_rounded,
                        color: kWhiteColor.withValues(alpha: 0.28),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Text(
                        "Today's P&L  $selectedPnl",
                        style: AppTextStyles.paragraphMedium.copyWith(
                          color: kWhiteColor.withValues(alpha: 0.88),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: kWhiteColor.withValues(alpha: 0.32),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.info_outline_rounded,
                        color: kWhiteColor.withValues(alpha: 0.24),
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            Container(
              width: 108,
              height: 74,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    kOrangeColor.withValues(alpha: 0.08),
                    kOrangeColor.withValues(alpha: 0.90),
                  ],
                  stops: const [0, 0.58, 1],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _BalanceInfoItem(
                label: 'Available balance',
                amount: '$availableBalance $selectedCurrency',
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: _BalanceInfoItem(
                label: 'In Use',
                amount: '$inUseBalance $selectedCurrency',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BalanceCurrencyDropdown extends StatelessWidget {
  const _BalanceCurrencyDropdown({
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
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF121316),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kWhiteColor.withValues(alpha: 0.06)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: kWhiteColor.withValues(alpha: 0.60),
          ),
          dropdownColor: const Color(0xFF15171B),
          borderRadius: BorderRadius.circular(16),
          style: AppTextStyles.paragraphSmall.copyWith(
            color: kWhiteColor.withValues(alpha: 0.76),
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

class _BalanceInfoItem extends StatelessWidget {
  const _BalanceInfoItem({
    required this.label,
    required this.amount,
  });

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.paragraphMedium.copyWith(
            color: kWhiteColor.withValues(alpha: 0.42),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: AppTextStyles.paragraphLarge.copyWith(
            color: kWhiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
