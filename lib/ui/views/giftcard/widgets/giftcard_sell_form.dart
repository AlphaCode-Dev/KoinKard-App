import 'package:flutter/material.dart';
import 'package:koinkard/ui/common/app_colors.dart';
import 'package:koinkard/ui/common/app_textstyles.dart';
import 'package:koinkard/ui/widgets/commons/koinkardbutton.dart';
import 'package:koinkard/ui/widgets/commons/koinkardinputfield.dart';

class GiftcardSellForm extends StatelessWidget {
  const GiftcardSellForm({
    super.key,
    required this.selectedBrand,
    required this.brands,
    required this.selectedCountry,
    required this.countries,
    required this.selectedPayoutMethod,
    required this.payoutMethods,
    required this.amountController,
    required this.codeController,
    required this.onBrandSelected,
    required this.onCountrySelected,
    required this.onPayoutMethodSelected,
  });

  final String selectedBrand;
  final List<String> brands;
  final String selectedCountry;
  final List<String> countries;
  final String selectedPayoutMethod;
  final List<String> payoutMethods;
  final TextEditingController amountController;
  final TextEditingController codeController;
  final ValueChanged<String> onBrandSelected;
  final ValueChanged<String?> onCountrySelected;
  final ValueChanged<String?> onPayoutMethodSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF101112),
        border: Border.all(
          color: kWhiteColor.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trade Details',
            style: AppTextStyles.headingXSmall.copyWith(
              color: kWhiteColor,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pick the card brand, amount, and payout route to estimate your cash-out value.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: kWhiteColor.withValues(alpha: 0.58),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Card brand',
            style: AppTextStyles.paragraphSmall.copyWith(
              color: kWhiteColor,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: brands
                .map(
                  (brand) => _BrandChip(
                    label: brand,
                    isSelected: brand == selectedBrand,
                    onTap: () => onBrandSelected(brand),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _TradeDropdown(
                  label: 'Country',
                  value: selectedCountry,
                  items: countries,
                  onChanged: onCountrySelected,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TradeDropdown(
                  label: 'Payout',
                  value: selectedPayoutMethod,
                  items: payoutMethods,
                  onChanged: onPayoutMethodSelected,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          KoinkardInputField(
            controller: amountController,
            label: 'Card amount',
            hintText: 'Enter card value e.g. 100',
            keyboardType: TextInputType.number,
            prefixIcon: Icon(
              Icons.attach_money_rounded,
              color: kWhiteColor.withValues(alpha: 0.76),
            ),
          ),
          const SizedBox(height: 16),
          KoinkardInputField(
            controller: codeController,
            label: 'Card note / code',
            hintText: 'Add card code, receipt note, or extra detail',
            maxLines: 3,
            minLines: 3,
            contentPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          ),
          const SizedBox(height: 18),
          const _GiftcardSummaryCard(),
          const SizedBox(height: 22),
          const KoinkardPrimaryButton(
            text: 'Trade Gift Cards',
          ),
        ],
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? kOrangeColor.withValues(alpha: 0.16)
              : kWhiteColor.withValues(alpha: 0.04),
          border: Border.all(
            color: isSelected
                ? kOrangeColor.withValues(alpha: 0.58)
                : kWhiteColor.withValues(alpha: 0.08),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.paragraphSmall.copyWith(
            color:
                isSelected ? kWhiteColor : kWhiteColor.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}

class _TradeDropdown extends StatelessWidget {
  const _TradeDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.paragraphSmall.copyWith(
            color: kWhiteColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: kWhiteColor.withValues(alpha: 0.06),
            border: Border.all(
              color: kWhiteColor.withValues(alpha: 0.1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: const Color(0xFF17191D),
              borderRadius: BorderRadius.circular(16),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: kWhiteColor.withValues(alpha: 0.72),
              ),
              style: AppTextStyles.bodyMedium.copyWith(
                color: kWhiteColor,
              ),
              onChanged: onChanged,
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _GiftcardSummaryCard extends StatelessWidget {
  const _GiftcardSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kOrangeColor.withValues(alpha: 0.16),
            kWhiteColor.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Column(
        children: const [
          _SummaryRow(
            label: 'Estimated payout',
            value: '92.00 USD',
            highlight: true,
          ),
          SizedBox(height: 14),
          _SummaryRow(
            label: 'Current rate',
            value: '920 NGN / 1 USD',
          ),
          SizedBox(height: 14),
          _SummaryRow(
            label: 'Settlement speed',
            value: 'Within 5 minutes',
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: kWhiteColor.withValues(alpha: 0.6),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.paragraphMedium.copyWith(
            color: highlight ? kOrangeColor : kWhiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
